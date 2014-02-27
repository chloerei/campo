class UserMailerPreview < MailView
  def password_reset
    user = User.first || FactoryGirl.create(:user)
    user.generate_password_reset_token
    UserMailer.password_reset(user.id)
  end
end
