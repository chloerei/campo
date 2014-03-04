# Only accept symbolize_keys here
ActionMailer::Base.smtp_settings = CONFIG['mailer']['smtp_settings'].symbolize_keys
ActionMailer::Base.default_url_options = CONFIG['mailer']['default_url_options'].symbolize_keys
ActionMailer::Base.default_options = CONFIG['mailer']['default_options'].symbolize_keys
