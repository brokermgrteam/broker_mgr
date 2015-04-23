module SalariesHelper
  
  def broker_salary(broker,month)
    @broker_salary = @broker.salaries.where(:month_id => month, :broker_id => broker.id) if @broker
  end
  
  def get_num(index)
    @sum = @broker_salary.where(:indextype => index).sum(:occursum)
    # number_with_precision(@broker_salary.where(:indextype => index).sum(:occursum))
  end
end
