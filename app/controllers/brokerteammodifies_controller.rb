# encoding: utf-8
class BrokerteammodifiesController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate

  def accept
    @brokerteammodify = Brokerteammodify.find(params[:brokerteammodify_id])
    redirect_to root_path
  end

  def deny

  end
end
