# encoding: utf-8
class RolesController < ApplicationController
  before_filter :authenticate
  
  def index
    @roles = Role.all
    @title = "用户角色"
  end

  def show
    @role  = Role.find(params[:id])
    @title = @role.name
  end

  def new
    @role  = Role.new
    @title = "新建角色"
  end
  
  def create
    @role = Role.new(params[:role])
    if @role.save
      redirect_to roles_path :flash => { :success => "角色新建成功"}
    else  
      @title = "新建角色"
      render 'new'
    end
  end

  def edit
    # raise request.inspect
    @role  = Role.find(params[:id])
    @title = "角色设置"
    @roles = Role.all
  end
  
  def update
    @role  = Role.find(params[:id])
    if @role.update_attributes(params[:role])
      redirect_to roles_path :flash => { :success => "角色更新成功" }
    else  
      @title = "角色设置"
      render 'edit'
    end 
  end
    
  def destroy
    Role.find(params[:id]).destroy
    # @role.destroy
    # flash[:success] = "用户已删除"
    redirect_to roles_path :flash => { :success => "角色已删除" }
  end

end

