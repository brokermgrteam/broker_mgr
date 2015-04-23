# encoding: utf-8
class BrokerindicesController < ApplicationController
  before_filter :authenticate
  
  def broker_index
    @brokerindex =  getbrokerindex(params[:broker_id], params[:id])
  end

  private
  
  def getbrokerindex(broker, type)
    @brokerindex = Brokerindex.find_all_by_broker_id_and_indextype(broker, type)
    # @brokerindex = Brokerindex.find_by_sql ["SELECT a.* FROM brokerindices a WHERE broker_id = ? and indextype = ?", broker, type]
  end
end