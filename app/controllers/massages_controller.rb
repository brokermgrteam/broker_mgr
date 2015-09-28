# encoding: utf-8
class MassagesController < ApplicationController
  load_and_authorize_resource
	before_filter :authenticate

  def new
    @massage  = Massage.new
    @massage.build_brokerteammodify
    @title = "起草消息"
  end

  def create
    @massage = Massage.new(params[:massage])
    # @massage.user = User.find(66336)
    @workflowunderway = Workflowunderway.create(:content => @massage.content,
                                                :workflow_id => Workflow.find_by_code("1002").id,
                                                :step => 1,
                                                :user_id => 66336)
    if @massage.save
      redirect_to notices_path, :flash => { :success => "消息已发送"}
    else
      @title = "起草消息"
      render 'new'
    end
  end

  def read
  	@massage = Massage.find(params[:massage_id])
  	@title = "消息列表"
    @massage.update_attribute :status, true
  	if @massage.save
  		redirect_to notices_path
  	end
  end

  def unread
    @massage = Massage.find(params[:massage_id])
    @title = "消息列表"
    @massage.update_attribute :status, false
    if @massage.save
  		redirect_to notices_path
  	end
  end

  def destroy
    Massage.find(params[:id]).destroy
    # @role.destroy
    # flash[:success] = "用户已删除"
    redirect_to massages_path, :flash => { :success => "消息已删除" }
  end
end
