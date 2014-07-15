# encoding: utf-8
class BrokercompliancelogsController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate, :only => [:index, :show]

  def index
    @broker = Broker.find(params[:id])
    @brokercompliancelogs = Brokercompliancelog.find_all_by_broker_id(@broker)
    @brokercompliance_grid = initialize_grid(Brokercompliancelog, 
              :order => 'Brokercompliancelog.month_id',
              :order_direction => 'desc',
              :conditions => {:broker_id => @broker}, 
              :name => 'brokers',
              :per_page => 5)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @brokercompliancelogs }
    end
  end
end
