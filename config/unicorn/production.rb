$worker = 2
#何秒経過すればワーカーを削除するか
$timeout = 30
#アプリ名　currentがつく
$app_dir = "/var/www/fakebook/current"
#リクエストを受け取るポートを指定
$listen = File.expand_path 'tmp/sokets/unicorn.socke', $app_dir
#PIDの管理
$pid = File.expand_path 'log/unicorn.pid', $app_dir
#エラーログを吐き出すファイルのディレクトリ
$std_log = File.expand_path 'log/unicorn.log', $app_dir

#上記設定が適応されるように定義
worker_processes  $worker
working_directory $app_dir
stderr_path $std_log
stdout_path $std_log
timeout $timeout
listen  $listen
pid $pid

#ホットデプロイ設定
preload_app true

#fork前に行うこと
before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      Process.kill "QUIT", File.read(old_pid).to_i
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

#fork後に行うこと
after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end