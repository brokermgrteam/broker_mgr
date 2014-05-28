# encoding: utf-8
class SessionsController < ApplicationController
  def new
    @title = "登录"
  end
 
  def create
    user = User.authenticate(params[:session][:usercode],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "用户名/密码错误"
      @title = "登录"
      render 'new'
    else
      sign_in user
      @session = Session.new({:user_id => user.id, :login_type => 1})
      @session.save
      if (signed_in?) && (can? :access_user_first_page, :all)
        redirect_to brokers_path
      # elsif (signed_in?) && (can? :access_broker_first_page, :all)
      #   redirect_to root_path
      else
        if user.first_login?
          redirect_to edit_user_path(user), :flash => { :error => "请及时修改您的初始密码" } 
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
end
