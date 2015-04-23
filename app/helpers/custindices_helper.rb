module CustindicesHelper
  def cust_index(cust,month)
    @cust_index = @cust.custindices.where(:month_id => month, :cust_id => cust.id) if @cust
  end
end
