# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def password_reset
    user = User.first || FactoryGirl.create(:user)
    UserMailer.password_reset(user.id)
  end

  def confirmation
    user = User.first || FactoryGirl.create(:user)
    UserMailer.confirmation(user.id)
  end
end
