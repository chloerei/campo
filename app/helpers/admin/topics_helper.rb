module Admin::TopicsHelper
  def link_to_admin_topic(topic)
    if topic.nil?
      "Topic had been destroy"
    else
      link_to topic.title, admin_topic_path(topic)
    end
  end
end
