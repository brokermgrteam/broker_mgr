# encoding: utf-8
class WorkflowsController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate

  def index
    @workflows = Workflow.all
    @title = "工作流程管理"
  end

  def show
    @workflow  = Workflow.find(params[:id])
    @title = @workflow.name
  end

  def new
    @workflow  = Workflow.new
    @title = "工作流程管理"
  end

  def create
    @workflow = Workflow.new(params[:workflow])
    @workflow.update_attribute :steps, @workflow.workflowsteps.count
    if @workflow.save
      redirect_to workflows_path, :flash => { :success => "工作流程新建成功"}
    else
      @title = "工作流程管理"
      render 'new'
    end
  end

  def edit
    @workflow  = Workflow.find(params[:id])
    @title = "工作流程管理"
    @workflows = Workflow.all
  end

  def update
    @workflow  = Workflow.find(params[:id])
    if @workflow.update_attributes(params[:workflow])
      @workflow.update_attribute :steps, @workflow.workflowsteps.count
      redirect_to workflows_path, :flash => { :success => "工作流程更新成功" }
    else
      @title = "工作流程管理"
      render 'edit'
    end
  end

  def destroy
    Workflow.find(params[:id]).destroy
    redirect_to workflows_path, :flash => { :success => "工作流程已删除" }
  end

end
