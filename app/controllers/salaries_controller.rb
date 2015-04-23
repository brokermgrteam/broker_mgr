# encoding: utf-8
class SalariesController < ApplicationController
  before_filter :authenticate
  
  def broker_salary
    @brokersalary =  getbrokersalary(params[:broker_id], params[:id])
  end
  
  private
  
  def getbrokersalary(broker, type)
    Salary.find_all_by_broker_id_and_indextype(broker, type)
  end
  
end
