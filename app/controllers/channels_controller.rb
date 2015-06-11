# encoding: utf-8
class ChannelsController < ApplicationController
	load_and_authorize_resource
	before_filter :authenticate, :only => [:index, :show, :edit, :update]

	def index
	  @channels_grid = initialize_grid(Channel,
	            :order => 'channels.channel_code',
	            :include => [:institution],
	            :name => 'channels',
	            :enable_export_to_csv => false,
	            :per_page => 20)
	  @title = "营销渠道"
	  # export_grid_if_requested('channels' => 'grid')
	end

  def show
    @channel  = Channel.find(params[:id])
    @title = @channel.channel_name

    @channelurls_grid = initialize_grid(Channelurl,
              :conditions => { :id => @channel.channelurls.map{|c| c.id} },
              # :include => [:custindices],
              # :name => 'brokerfavcusts',
              :per_page => 10) if @channel
  end

  def new
    @channel  = Channel.new
    @title = "新建渠道"
  end

  def create
    @channel = Channel.new(params[:channel])
    @channel.status = true
    if @channel.save
      redirect_to channels_path, :flash => { :success => "渠道新建成功"}
    else
      @title = "新建渠道"
      render 'new'
    end
  end

  def edit
    @channel  = Channel.find(params[:id])
    @title = "渠道设置"

		@subchannels_grid = initialize_grid(Subchannel,
		            :order => 'subchannels.sub_channel_code',
								:conditions => { :id => @channel.subchannels.map{|c| c.id} },
		            :name => 'subchannels',
		            :enable_export_to_csv => false,
		            :per_page => 10)
  end

  def update
    @channel  = Channel.find(params[:id])
    if @channel.update_attributes(params[:channel])
      redirect_to channels_path, :flash => { :success => "渠道更新成功" }
    else
      @title = "渠道设置"
      render 'edit'
    end
  end

end
