# encoding: utf-8
class SubchannelsController < ApplicationController
  load_and_authorize_resource
	before_filter :authenticate, :only => [:index, :show, :edit, :update]

  def new
    @subchannel  = Subchannel.new
    @channel = Channel.find(params[:channel])

    if @channel.subchannels.empty?
      @sub_channel_code = 101
    else
      @sub_channel_code = @channel.subchannels.map{|a| a.sub_channel_code}.max.to_i + 1
    end

    @title = "新建二级渠道"
  end

  def create
    @channel = Channel.find(params[:subchannel][:channel_id])
    @subchannel = Subchannel.new(params[:subchannel])
    @subchannel.status = true
    if @subchannel.save
      redirect_to edit_channel_path(@channel), :flash => { :success => "二级渠道新建成功"}
    else
      @title = "新建渠道"
      render 'new'
    end
  end
end
