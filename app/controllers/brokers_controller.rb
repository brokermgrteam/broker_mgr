# encoding: utf-8
class BrokersController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate, :only => [:index, :show]
  
  def show
    @broker = Broker.find(params[:id])
    @title  = @broker.broker_code + " - " + @broker.broker_name
    @branch = @broker.branch
    @father_department = @branch.department
    @salary_months = @broker.brokerindices.limit(3).where(:indextype => 2009).reverse_order
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @broker }
    end
  end
  
  def index
    # @brokers = Broker.all
    @brokers_grid = initialize_grid(Broker, 
              :conditions => {:branch_id => Branch.accessible_by(current_ability).map{|br| [br.id]}}, 
              :include => [:branch],
              :name => 'brokers',
              :enable_export_to_csv => true,
              :csv_field_separator => ';',
              :csv_file_name => '导出',
              :per_page => 20)
    @title = "营销人员"
    export_grid_if_requested('brokers' => 'grid')
  end
  
  def relbrokers
    @title = "关联帐户"
    @broker = Broker.find(params[:id])
    @brokers = @broker.relbrokers
    render 'categories/search'
  end
end
