# encoding: utf-8
class NoticesController < ApplicationController
	before_filter :authenticate

	def index
    @notices = Notice.all
    @title = "通知列表"
    @unreads = Notice.unread(current_user).recent
    @reads = current_user.notices.recent
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

  def unread
    @notice = Notice.find(params[:notice_id])
    @title = "通知列表"
    Readnotice.find_by_notice_id_and_user_id(params[:notice_id], current_user).destroy
    
    redirect_to notices_path
  end

  def destroy
    Notice.find(params[:id]).destroy
    # @role.destroy
    # flash[:success] = "用户已删除"
    redirect_to notices_path, :flash => { :success => "通知已删除" }
  end
end
