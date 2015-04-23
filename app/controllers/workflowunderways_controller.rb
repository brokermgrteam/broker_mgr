# encoding: utf-8
class WorkflowunderwaysController < ApplicationController
  # include Wicked::Wizard
  load_and_authorize_resource
  before_filter :authenticate
  # prepend_before_filter :set_steps
  # steps :custserv_1, :custserv_2
  
  def index
    # @workflowunderways = Workflowunderway.accessible_by(current_ability)
    @title = "待办列表"
    @workflowunderways = Workflowunderway.order("code").paginate(:page => params[:page]).per_page(20)
    # @department = params[:department]
    @workflowunderways_grid = initialize_grid(Workflowunderway, 
              :conditions => {:user_id => current_user.id}, 
              :include => [:workflow],
              :name => 'workflowunderways',
              # :enable_export_to_csv => true,
              :csv_field_separator => ';',
              :csv_file_name => '导出',
              :per_page => 20)
    # export_grid_if_requested('workflowunderways' => 'grid')
  end
  
  def new
    @workflowunderway = Workflowunderway.new
    @workflowunderway.build_custservvisit
    @title = "新建"
  end
  
  def show
    @title = "流程步骤"
    @workflowunderway = Workflowunderway.find(params[:id])
    @workflow = @workflowunderway.workflow
    # @next_step = 'custserv_2'
    # @current_step = 'custserv_1'
    # current_step = 1
    # render_wizard
  end
  
  def edit
    @workflowunderway  = Workflowunderway.find(params[:id])
    @title = "修改"
  end
  
  def create
    @workflowunderway = Workflowunderway.new(params[:workflowunderway])
    # @custservvisit.status = get_dict("TaskBase.taskStatus",0).id
    if @workflowunderway.save
      redirect_to root_path, :flash => { :success => "营销工作任务已设置"}
    else  
      @title = "营销工作任务"
      render 'new'
    end
  end
  
  def update
    @workflowunderway  = Workflowunderway.find(params[:id])
    if @workflowunderway.update_attributes(params[:workflowunderway])
      if last_step(@workflowunderway)
        redirect_to root_path, :flash => { :success => "提交成功" }
      else
        redirect_to workflowunderway_workflow_step_path(@workflowunderway, current_step(@workflowunderway)), 
                    :flash => { :success => "提交成功" }
      end
    else  
      @title = "营销工作任务"
      render 'edit'
    end
  end
  
  private
  def last_step(workflowunderway)
    laststep = workflowunderway.workflow.steps
    if workflowunderway.step == laststep
      @workflowhistory = Workflowhistory.new({:content => params[:workflowunderway][:content],
                      :remark => params[:workflowunderway][:remark],
                      :workflow_id => params[:workflowunderway][:workflow_id],
                      :user_id => params[:workflowunderway][:user_id],
                      :id => workflowunderway.id})
      if @workflowhistory.save
        workflowunderway.destroy
      end
    end
  end
  # def set_steps
  #   if params[:flow] == "营销工作任务"
  #     self.steps = [:custserv_1, :custserv_2]
  #   elsif params[:flow] == "facebook"
  #     self.steps = [:ask_facebook, :ask_email]
  #   end
  # end
end
