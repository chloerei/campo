class UserMailer < ActionMailer::Base
  include Resque::Mailer

  helper :markdown
  default from: CONFIG['mailer']['default_from']

  def password_reset(user_id)
    @user = User.find(user_id)
    I18n.locale = @user.locale
    mail(to: @user.email,
         subject: I18n.t('user_mailer.password_reset.subject'))
  end
end
