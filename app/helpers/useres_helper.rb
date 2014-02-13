module UseresHelper
  def user_link(user)
    user_root_path(username: user.username)
  end
end
