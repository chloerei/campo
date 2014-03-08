module TopicsHelper
  def topic_last_path(topic)
    topic_path(topic, page: (topic.total_pages if topic.total_pages > 1), anchor: (topic.comments_count if topic.comments_count > 0))
  end
end
