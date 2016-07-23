class RoomsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:push]

  def show
    @messages = Message.all
  end

  def push
    data = Message.first
    data = Message.new(sale: 0, refund: 0, tip: 0, void: 0) if data.nil?

    data.refund = params[:refund] unless params[:refund].nil?
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
