# encoding: utf-8
class BrokerteammodifiesController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate

  def accept
    @brokerteammodify = Brokerteammodify.find(params[:id])
    @brokerteammodify.update_attribute :status, get_dict('BrokerTeam.opinion', 1).id

    redirect_to root_path :flash => { :success => "团队变更流程已处理" }
  end

  def deny
    @brokerteammodify = Brokerteammodify.find(params[:id])
    @brokerteammodify.update_attribute :status, get_dict('BrokerTeam.opinion', 2).id

    redirect_to root_path :flash => { :success => "团队变更流程已处理" }
  end
end
