# encoding: utf-8
class WorkflowStepsController < ApplicationController
  include Wicked::Wizard
  # load_and_authorize_resource
  before_filter :set_steps
  before_filter :setup_wizard
  before_filter :authenticate
  # prepend_before_filter :set_steps
  # steps :custserv_exe

  def show
    # case @workflow.code
    # when
    @title = "营销工作流程"
    @workflowunderway = Workflowunderway.find(params[:workflowunderway_id])
    @workflow = @workflowunderway.workflow

    render_wizard
  end

  private

  def set_steps
    if params[:flow] == "1001"
      self.steps = [:custserv_exe]
    elsif params[:flow] == "1002"
      self.steps = [:brokerteammodify_exe]
    end
  end
end
