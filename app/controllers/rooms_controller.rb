class RoomsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:push]

  # Basic auth for API
  # The Authorization field is constructed as follows:

  # The username and password are combined with a single colon.
  # The resulting string is encoded using Base64,
  # (if the username and password are long use RFC2045-MIME variant of Base64 which is not limited to 76 char/line.
  # The authorization method and a space i.e. "Basic " is then put before the encoded string.
  # For example, if the user agent uses Aladdin as the username and OpenSesame as the password then the field is formed as follows:

  # Authorization: Basic QWxhZGRpbjpPcGVuU2VzYW1l
  # which is send in header

  # byebug
  http_basic_authenticate_with name: Rails.application.secrets.api_auth_username,
                               password: Rails.application.secrets.api_auth_password,
                               except: [:show]

  def show
    @messages = Message.all
  end

  def push

    # /^(sale|tip|void|refund|connection_status)_(value|count)|connection_status$/

    param_keys = params.keys
    # if param_keys.contains? "connection_status"

    # end

    types_in_request = Set.new
    param_keys.each do |key|
      if clean_key = key.match(/^(sale|tip|void|refund)/)
        types_in_request.add clean_key.to_s
      end
    end

    successful_save = false
    types_in_request.to_a.each do |key|
      # clean_key = key.match(/^(sale|tip|void|refund)/).to_s
      m = Message.find_or_create_by(txn_type: key)
      m.total_count = params[key+"_count"] if params[key+"_count"]
      m.total_value = params[key+"_value"] if params[key+"_value"]
      successful_save = m.save
    end

    if successful_save
      respond_to do |format|
        format.html  { render plain: "ok" }
        format.json  { render json: { result: true,  message: "Push Success" }.to_json }
      end
    end
  end
end
