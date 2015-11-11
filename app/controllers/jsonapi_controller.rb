# encoding: utf-8
class JsonapiController < ApplicationController
  # load_and_authorize_resource
  before_filter :authenticate

  def brokerteamrels
    @brokerteamrels = Brokerteamrel.find_all_by_broker_id(params[:broker_id])
  end
end
