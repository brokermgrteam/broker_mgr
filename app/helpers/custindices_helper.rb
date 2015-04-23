module CustindicesHelper
  def cust_index(custmonth)
    @cust_index = @cust.custindices.where(:month_id => month :cust_id => cust.id) if @cust
  end
end
