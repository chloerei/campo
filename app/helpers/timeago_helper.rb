module TimeagoHelper
  def time_ago_tag(time)
    time_tag time, data: { behaviors: 'timeago' }
  end
end
