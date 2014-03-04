module ApplicationHelper
  def return_to_path(path)
    case path
    when '/', /^\/login/, /^\/signup/
      nil
    else
      path
    end
  end
end
