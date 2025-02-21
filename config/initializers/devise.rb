require_relative "../../lib/custom_failure_app"

Devise.setup do |config|
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  require 'devise/orm/active_record'

  config.authentication_keys = [:user_code]
  config.reset_password_keys = [:user_code]
  config.confirmation_keys = [:user_code]
  config.case_insensitive_keys = [:user_code]
  config.strip_whitespace_keys = [:user_code]

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]

  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 12
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..128
  config.reset_password_within = 6.hours
  config.scoped_views = true
  config.sign_out_via = :delete

  config.responder.error_status = :unprocessable_entity
  config.responder.redirect_status = :see_other

  config.warden do |manager|
    manager.failure_app = CustomFailureApp
  end
end
