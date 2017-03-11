module TopicsHelper
  def chose_new
    if action_name == 'new'
      topics_path
    else
      edit_topic_path
    end
  end

end
