# encoding: utf-8
class GeneratechannelsController < ApplicationController
	load_and_authorize_resource
	before_filter :authenticate

	def new
		@title = "生成渠道链接"
	end

  def create
    # @role = Role.new(params[:role])
    # if @role.save
    #   redirect_to roles_path, :flash => { :success => "角色新建成功"}
    # else  
    #   @title = "新建角色"
    #   render 'new'
    # end
  end

	def get_url
		
	end
end
