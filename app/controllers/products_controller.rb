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
  
end
