module TopicsHelper
  def chose_new
    if action_name == 'new'
      confirm_topics_path
    end
  end

end
