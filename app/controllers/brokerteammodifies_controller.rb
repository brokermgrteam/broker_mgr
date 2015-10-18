# encoding: utf-8
class BrokerteammodifiesController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate

  def accept
    @brokerteammodify = Brokerteammodify.find(params[:id])
    @brokerteammodify.update_attribute :status, get_dict('BrokerTeam.opinion', 1).id
    @brokerteammodify.massage.update_attribute :status, true

    @workflowunderway  = @brokerteammodify.workflowunderway

    if last_step(@workflowunderway)
      redirect_to root_path :flash => { :success => "团队变更流程已处理" }
    else
      @title = "营销工作流程"
      redirect_to root_path :flash => { :error => "处理失败" }
    end
  end

  def deny
    @brokerteammodify = Brokerteammodify.find(params[:id])
    @brokerteammodify.update_attribute :status, get_dict('BrokerTeam.opinion', 2).id
    @brokerteammodify.massage.update_attribute :status, true
    
    @workflowunderway  = @brokerteammodify.workflowunderway

    if last_step(@workflowunderway)
      redirect_to root_path :flash => { :success => "团队变更流程已处理" }
    else
      @title = "营销工作流程"
      redirect_to root_path :flash => { :error => "处理失败" }
    end
  end

  private
  def last_step(workflowunderway)
    laststep = workflowunderway.workflow.steps
    if workflowunderway.step == laststep
      @workflowhistory = Workflowhistory.new({:content => workflowunderway.content,
                      :remark => workflowunderway.remark,
                      :workflow_id => workflowunderway.workflow_id,
                      :user_id => workflowunderway.user_id,
                      :id => workflowunderway.id})
      if @workflowhistory.save
        workflowunderway.destroy
      end
    end
  end
end
