# encoding: utf-8
class CustsController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate, :only => [:index, :show, :edit, :update, :productcusts_index, :cust_detail_index]
  
  def index
    @custs = Cust.order("name").paginate(:page => params[:page]).per_page(20)
    @department = params[:department]
    if params[:broker_id]
      @broker = Broker.find(params[:broker_id])
    else
      @broker = Broker.find_by_user_id(current_user.id)
    end
    @custs_grid = initialize_grid(Cust, 
              :include => [:branch, :custbrokerrels],
              :conditions => [ " CUSTBROKERRELS.BROKER_ID = ? ", @broker ], 
              :name => 'custs',
              # :enable_export_to_csv => true,
              # :csv_field_separator => ';',
              # :csv_file_name => '导出',
              :per_page => 20)
    @title = "我的客户"
    export_grid_if_requested('custs' => 'grid')
  end

  def productcusts_index
    # @custs = Cust.order("name").paginate(:page => params[:page]).per_page(20)
    @department = params[:department]
    if params[:broker_id]
      @broker = Broker.find(params[:broker_id])
    else
      @broker = Broker.find_by_user_id(current_user.id)
    end
    @productcusts_grid = initialize_grid(Cust, 
              :include => [:branch, :custbrokerproductrels],
              :conditions => [ " CUSTBROKERPRODUCTRELS.BROKER_ID = ? ", @broker ], 
              :name => 'productcusts',
              # :enable_export_to_csv => true,
              # :csv_field_separator => ';',
              # :csv_file_name => '导出',
              :per_page => 20)
    @title = "营销产品客户"
    export_grid_if_requested('productcusts' => 'grid')
  end

  def cust_detail_index
    @custs = Cust.order("name").paginate(:page => params[:page]).per_page(20)
    @department = params[:department]
    if params[:broker_id]
      @broker = Broker.find(params[:broker_id])
    else
      @broker = Broker.find_by_user_id(current_user.id)
    end
    @custs_grid = initialize_grid(Cust, 
              :include => [:branch, :custbrokerrels],
              :conditions => [ " CUSTBROKERRELS.BROKER_ID = ? ", @broker ], 
              :name => 'custs',
              # :enable_export_to_csv => true,
              # :csv_field_separator => ';',
              # :csv_file_name => '导出',
              :per_page => 20)
    @title = "客户业绩"
  end

  def show
    @cust  = Cust.find(params[:id])
    @title = @cust.cust_name
  end
end
