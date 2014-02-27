class UserMailer < ActionMailer::Base
  default from: CONFIG['mailer']['default_from']

  helper :markdown

  def password_reset(user_id)
    @user = User.find(user_id)
    I18n.locale = @user.locale
    mail(to: @user.email,
         subject: I18n.t('user_mailer.password_reset.subject'))
  end
end
