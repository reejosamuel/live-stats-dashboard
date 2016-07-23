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
    data = Message.first
    data = Message.new(sale: 0, refund: 0, tip: 0, void: 0) if data.nil?

    # data.refund = params[:refund] unless params[:refund].nil?
    data.sale   = params[:sale] unless params[:sale].nil?
    data.tip    = params[:tip] unless params[:tip].nil?
    data.void   = params[:void] unless params[:void].nil?
    data.connection_status = params[:connection_status] unless params[:connection_status].nil?

    if data.save
      respond_to do |format|
        format.html  { render plain: "ok" }
        format.json  { render json: { result: true,  message: "Push Success" }.to_json }
      end
    end
  end
end
