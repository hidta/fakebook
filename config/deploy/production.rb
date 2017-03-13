server '13.112.170.38', user: 'app', roles: %w{app db web}
set :ssh_options, key: '/root/.ssh/id_rsa'