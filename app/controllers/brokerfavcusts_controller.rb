# encoding: utf-8
class BrokerfavcustsController < ApplicationController
	before_filter :authenticate

  def create
    @cust = Cust.find(params[:brokerfavcust][:cust_id])
    Broker.find_by_user_id(current_user.id).favor_cust!(@cust)
    respond_to do |format|
       format.html { redirect_to @cust }
       format.js
     end
  end
  
  def destroy
    @cust = Brokerfavcust.find(params[:id]).cust
    Broker.find_by_user_id(current_user.id).unfavor_cust!(@cust)
    respond_to do |format|
      format.html { redirect_to @cust }
      format.js
    end
  end	
end
