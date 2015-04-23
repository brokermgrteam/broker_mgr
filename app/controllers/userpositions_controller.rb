# encoding: utf-8
class UserpositionsController < ApplicationController
  before_filter :authenticate
  
  def index
    @userpositions = Userposition.all
    @title = "审批岗位"
  end

  def show
    @userposition  = Userposition.find(params[:id])
    @title = @userposition.name
  end

  def new
    @userposition  = Userposition.new
    @title = "审批岗位"
  end
  
  def create
    @userposition = Userposition.new(params[:userposition])
    if @userposition.save
      redirect_to userpositions_path, :flash => { :success => "角色新建成功"}
    else  
      @title = "审批岗位"
      render 'new'
    end
  end

  def edit
    @userposition  = Userposition.find(params[:id])
    @title = "审批岗位"
    @userpositions = Userposition.all
  end
  
  def update
    @userposition  = Userposition.find(params[:id])
    if @userposition.update_attributes(params[:userposition])
      redirect_to userpositions_path, :flash => { :success => "审批岗位更新成功" }
    else  
      @title = "审批岗位"
      render 'edit'
    end 
  end
    
  def destroy
    Userposition.find(params[:id]).destroy
    # @role.destroy
    # flash[:success] = "用户已删除"
    redirect_to userpositions_path, :flash => { :success => "审批岗位已删除" }
  end
  
end
