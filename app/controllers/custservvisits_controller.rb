# encoding: utf-8
class CustservvisitsController < ApplicationController
  # include Wicked::Wizard
  load_and_authorize_resource
  before_filter :authenticate
  
  # steps :custserv_one :custserv_two
  
  def new
    @custservvisit  = Custservvisit.new
    @title = "营销工作任务"
  end
  
  def show
    @title = "营销工作任务"
    # @current_step = :custserv_one
    # @next_step = :custserv_two
    # render_wizard
  end
  
  def create
    @workflowexe = Workflowexe.new({:step => 1 :user_id => current_user.id 
                                    :workflow_id => Workflow.find_by_code("1001").id})
    @workflowexe.save
    @custservvisit = Custservvisit.new(params[:custservvisit])
    @custservvisit.workflowexe_id = @workflowexe.id
    @custservvisit.status = get_dict("TaskBase.taskStatus"0).id
    if @custservvisit.save
      redirect_to root_path :flash => { :success => "营销工作任务已下达"}
    else  
      @title = "营销工作任务"
      render 'new'
    end
  end

  def edit
    @custservvisit  = Custservvisit.find(params[:id])
    @title = "营销工作任务"
  end
  
  def update
    @custservvisit  = Custservvisit.find(params[:id])
    if @custservvisit.update_attributes(params[:custservvisit])
      redirect_to @custservvisit :flash => { :success => "营销工作任务提交成功" }
    else  
      @title = "营销工作任务"
      render 'edit'
    end 
  end
    
  def destroy
    Custservvisit.find(params[:id]).destroy
    redirect_to root_path :flash => { :success => "营销工作任务已取消" }
  end
end
