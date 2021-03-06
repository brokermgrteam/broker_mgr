# encoding: utf-8
class RecoverypasswordsController < ApplicationController
	def new
    @title = "忘记密码"
    flash.now[:error] = "注意！提交申请后，您注册的手机会收到一条验证码。"
  end

  def create
  	user = User.find_by_usercode_and_certificate_num(params[:recoverypassword][:usercode],
                             												 params[:recoverypassword][:certificate_num])
    if user.nil?
      @title = "忘记密码"
      respond_to do |format|
         format.html { redirect_to root_path, :flash => { :error => "输入不正确，请重新输入" } }
         format.js { render :action => "reject" }
      end
    else
      @recoverypassword = Passwordresetlog.create(:user_id => user.id,
                                                  :confirm_code => rand(1_000_00..10_000_00-1),
                                                  :mobile => user.mobile,
                                                  :status => 0)
      respond_to do |format|
         format.html { redirect_to root_path, :flash => { :success => "请查收短信确认码" } }
         format.js
      end
    end
  end

  def confirm
    @title = "输入短信确认码"
    @recoverypassword = Passwordresetlog.find(params[:passwordresetlog][:passwordresetlog_id])
  end

  def update
    @recoverypassword = Passwordresetlog.find(params[:passwordresetlog][:passwordresetlog_id])
    @user = User.find(@recoverypassword.user_id)
    if @recoverypassword.confirm_code == params[:passwordresetlog][:confirm_code]
      @user.update_attribute :first_login, false
      @recoverypassword.update_attribute :status, 1
			sign_in @user
      respond_to do |format|
           format.html { redirect_to edit_user_path(@user), :flash => { :error => "请及时修改您的初始密码" } }
           format.js
      end
    else
      respond_to do |format|
           format.html { redirect_to root_path, :flash => { :error => "验证码输入错误，请稍后再试" } }
           format.js
      end
    end
  end
end
