# encoding: utf-8
class NoticesController < ApplicationController
	before_filter :authenticate

	def index
    @notices = Notice.all
    @title = "通知列表"
  end

  def show
    @notice = Notice.find(params[:id])
    @title = @notice.title
  end

  def new
    @notice  = Notice.new
    @title = "起草通知"
  end
  
  def create
    @notice = Notice.new(params[:notice])
    @notice.user = current_user
    if @notice.save
      redirect_to notices_path, :flash => { :success => "通知已发送"}
    else  
      @title = "起草通知"
      render 'new'
    end
  end
  
  def read
  	@notice = Notice.find(params[:notice_id])
  	@title = "通知列表"
  	@notice.readnotices.build(:user_id => current_user.id)
  	if @notice.save
  		redirect_to notices_path
  	end
  end

  def destroy
    Notice.find(params[:id]).destroy
    # @role.destroy
    # flash[:success] = "用户已删除"
    redirect_to root_path, :flash => { :success => "通知已删除" }
  end
end
