class RoomsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:push]

  def show
    @messages = Message.all
  end

  def push
    data = Hash.new
    data["refund"] = params[:refund] unless params[:refund].nil?
    data["sale"] = params[:sale] unless params[:sale].nil?
    data["tip"] = params[:tip] unless params[:tip].nil?
    data["void"] = params[:void] unless params[:void].nil?
    ActionCable.server.broadcast 'room_channel', data

    respond_to do |format|
      format.html  { head :ok }
      format.json  { render json: { result: true,  message: "Push Success" }.to_json }
    end
  end
end
