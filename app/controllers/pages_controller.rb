# encoding: utf-8
class PagesController < ApplicationController
  def home
    @title = "首页"
    if signed_in?
      @title = "首页"
      @broker = Broker.valid_brokers.find_by_user_id(current_user.id) unless Broker.find_by_user_id(current_user.id).nil?
      @workflowunderways = Workflowunderway.where(:user_id => current_user.id).limit(5).order('created_at desc')
      @brokerproducts = @broker.products if @broker
      @newproducts = Product.find(:all, :order => "id desc", :limit => 10)
        
      @brokerfavcusts_grid = initialize_grid(Cust, 
                :conditions => { :id => @broker.brokerfavcusts.map{|c| c.cust_id} },
                :include => [:custindices],
                # :name => 'brokerfavcusts',
                :per_page => 5)

      # @brokers = Broker.accessible_by(current_ability)
      if (can? :access_user_first_page, :all)
        redirect_to brokers_path
      end
    end
    
  end

  def contact
    @title = "联系"
  end
  
  def about
    @title = "关于"
  end
  
  def help
    @title = "帮助"
  end
  
end
