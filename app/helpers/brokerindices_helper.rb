module BrokerindicesHelper
  def find_brokerindex(index, broker)
    @current_month = Time.now.strftime("%Y%m")
    @brokerindex = Brokerindex.find_by_broker_id_and_indextype_and_month_id(broker, index, @current_month) if (broker && index)
    (@brokerindex.occursum if @brokerindex && @brokerindex.occursum != 0) || 0
  end
end
