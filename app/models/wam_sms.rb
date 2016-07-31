class WamSms

  require 'httparty'
  include HTTParty

  # Disable SSL Verification on CA since
  # its failing on this particular vendor
  # until futher investigation on the issue
  # verification of the CA is disabled,
  # security risk is 'LOW'

  default_options.update(verify: false)

  # debug_output $stderr

  base_uri "https://messaging.wamsms.com"

  def initialize(username, password)
    @params = { user: username, password: password }
  end

  def send_sms(senderid, to, message)
    @params[:senderid] = senderid
    @params[:mobiles]  = to
    @params[:sms]      = message

    options = {
                query: @params,
                headers: { "User-Agent" => "Swiftch Scorecard 0.0.1" }
              }

    Rails.logger.info "Sending SMS: to: #{@params[:mobiles]} text: #{@params[:sms]}"
    process_response self.class.get("/sendsms.jsp", options)
  end

  private
    def process_response data
      response = data["smslist"]
      unless response.has_key?("error")
        Rails.logger.info "SMS Sent with Message ID: #{response["sms"]["messageid"]}"
        return true
      else
        error_mesg = response["error"]
        Rails.logger.info "SMS Sending failed with Error Code: #{error_mesg["error_code"]}: #{error_mesg["error_description"]}"
        return false
      end
    end
end