module BrokerindicesHelper
  def find_brokerindex(index, broker)
    @current_month = Time.now.strftime("%Y%m")
    @month = (Time.now.strftime("%Y%m") if Brokerindex.find_by_month_id(@current_month)) || (DateTime.now - 1.month).strftime("%Y%m")
    @brokerindex = Brokerindex.find_by_broker_id_and_indextype_and_month_id(broker, index, @month) if (broker && index)
    (@brokerindex.occursum if @brokerindex && @brokerindex.occursum != 0) || 0
  end
end
