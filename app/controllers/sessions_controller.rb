# encoding: utf-8
class SessionsController < ApplicationController
  def new
    @title = "登录"
  end

  def create
    if Licence.last.verify?(APP_CONFIG['key']) == false
      redirect_to root_path, :flash => { :error => "系统已过期" }
      return
    end
    @user = User.find(:last, :conditions => ["mobile = ? or email = ?", params[:session][:usercode], params[:session][:usercode]])

    @broker = Broker.valid_brokers.find_by_user_id(@user) if @user
    @usercode = @user.usercode if @user #((@broker.user.usercode if @broker) || (@user.usercode if Broker.valid_brokers.find_by_user_id(@user.id) == nil)) unless (@user == nil && @broker == nil)

    user = User.authenticate(@usercode, params[:session][:password])

    if user.nil?
      if @user
        try_lock_user(@user)
        if @user.failed_times >= APP_CONFIG['login_failed_times']
          flash.now[:error] = "用户已冻结,请24小时后重试"
        else
          flash.now[:error] = "用户名/密码错误,请输入邮箱或手机号码尝试"
        end
      else
        flash.now[:error] = "用户名/密码错误,请输入邮箱或手机号码尝试"
      end
      @title = "登录"
      render 'new'
    else
      sign_in user
      @session = Session.new({:user_id => user.id, :login_type => 1})
      @session.save
      if signed_in?
        if can? :access_user_first_page, :all
          redirect_to brokers_path
        # elsif (signed_in?) && (can? :access_broker_first_page, :all)
        #   redirect_to root_path
        else
          if Usersign.find_by_user_id_and_sign_date(user.id, Date.today).nil?
            Usersign.create(:user_id => user.id, :sign_date => Date.today)
              redirect_to root_path, :flash => { :success => "您今日已成功签到" }
          else
            redirect_back_or root_path #user #friendly redirect
          end
        end
      end
    end
  end

  def destroy
    sign_out
    redirect_to root_path, :flash => { :alert => "您已退出" }
  end

  private

    def try_lock_user(user)
      @user = User.find(user)
      user.update_attribute :failed_times, (user.failed_times + 1 if user.failed_times) || 1
      if (user.failed_times >= APP_CONFIG['login_failed_times'] && @user.status != Dict.find_by_dict_type_and_code("UserBase.status", 3).id)
        user.update_attribute :status, Dict.find_by_dict_type_and_code("UserBase.status", 3).id

        user.delay(run_at: 1.day.from_now).update_attribute :status, Dict.find_by_dict_type_and_code("UserBase.status", 1).id
        user.delay(run_at: 1.day.from_now).update_attribute :failed_times, 0
      end
    end
end
