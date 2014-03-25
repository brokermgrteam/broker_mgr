# encoding: utf-8
class ProductsController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate
  
  def index
    @products = Product.order("name").paginate(:page => params[:page]).per_page(20)
    @products_grid = initialize_grid(Product, 
              # :conditions => {:branch_id => Branch.accessible_by(current_ability).map{|br| [br.id]}}, 
              # :include => [:department, :branch],
              :name => 'products',
              :enable_export_to_csv => true,
              :per_page => 20)
    @title = "营销产品"
    export_grid_if_requested('products' => 'grid')
  end

  def show
    @product  = Product.find(params[:id])
    @title    = @product.name
  end

  def downloadfile
    @product  = Product.find(params[:id])
    @seq      = params[:seq]
    if @product.f1!=nil && @seq=="1"
      send_data @product.f1, :filename => @product.f1_name
    end
    if @product.f2!=nil && @seq=="2"
      send_data @product.f2, :filename => @product.f2_name
    end
    if @product.f3!=nil && @seq=="3"
      send_data @product.f3, :filename => @product.f3_name
    end
  end
end
