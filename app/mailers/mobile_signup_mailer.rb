class MobileSignupMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

  def confirmation_instructions(record, token, opts={})
    initialize_from_record(record)
    send_sms :confirmation, token
    super if Rails.application.secrets.send_auth_emails?
  end

  def reset_password_instructions(record, token, opts={})
    initialize_from_record(record)
    send_sms :reset_password_instructions, token
    super if Rails.application.secrets.send_auth_emails?
  end

  # Unlockable module is disabled, if required additional
  # configuration for mobile sms is required before
  # continuing
  # def unlock_instructions(record, token, opts={})
  #   initialize_from_record(record)
  #   send_sms :reset_password_instructions, token
  #   super if Rails.application.secrets.send_auth_emails?
  # end

  def password_change(record, opts={})
    initialize_from_record(record)
    send_sms :password_change, token
    super if Rails.application.secrets.send_auth_emails?
  end

  private

    def send_sms action, token
      client = WamSms.new(Rails.application.secrets.sms_username,
                        Rails.application.secrets.sms_password)

      sms_body = I18n.t "sms.#{action}", code: token
      client.send_sms("Sender ID", resource.mobile, sms_body)
    end
end