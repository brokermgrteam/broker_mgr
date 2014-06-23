# encoding: utf-8
class ChannelurlsController < ApplicationController
	require "uri"
  require "net/http"
  require "json"
  
  def new
    @title = "获取渠道连接"
  end
    
  def create
    @broker = Broker.find(params[:channelurl][:broker]) unless params[:channelurl][:broker].empty?
    @open_branch = Branch.find(params[:channelurl][:cust_branch]) unless params[:channelurl][:cust_branch].empty?
    @serv_branch = Branch.find(params[:channelurl][:cust_branch]) unless params[:channelurl][:cust_branch].empty?
  	a = {
    'channel_id' => params[:channelurl][:channel],
    'channel_code' => Channel.find(params[:channelurl][:channel]).channel_code,
    'channel_name' => Channel.find(params[:channelurl][:channel]).channel_code,
    'institution_id' => Channel.find(params[:channelurl][:channel]).institution_id,
    'institution_code' => Institution.find(Channel.find(params[:channelurl][:channel]).institution_id).institution_code,
    'institution_name' => Institution.find(Channel.find(params[:channelurl][:channel]).institution_id).institution_name,
    'open_branch_id' => params[:channelurl][:cust_branch],
    'open_branch_code' => (@open_branch.code unless @open_branch.nil?),
    'open_branch_name' => (@open_branch.name unless @open_branch.nil?),
    'serv_branch_id' => params[:channelurl][:channel_branch],
    'serv_branch_code' => (@serv_branch.code unless @serv_branch.nil?),
    'serv_branch_name' => (@serv_branch.name unless @serv_branch.nil?),
    'broker_id' => params[:channelurl][:broker],
    'broker_code' => (@broker.broker_code unless @broker.nil?),
    'broker_name' => (@broker.broker_name unless @broker.nil?) 
    }
    x = Net::HTTP.post_form(URI.parse(APP_CONFIG['channel_url_generator']), a)
    @url = JSON.parse(x.body)[APP_CONFIG['channel_url_function']]
    # @url = "http://www.google.com/"
    @channelurl = Channelurl.new(:url => @url)
    if @channelurl.save
      # redirect_to @channelurl # render channelurl_path(@channelurl)
      respond_to do |format|
        format.html { redirect_to @channelurl, :flash => { :success => "URL获取成功" } }
        format.js
      end
    end
    # respond_to do |format|
    #   format.html { redirect_to @url, :flash => { :success => "URL获取成功" } }
    #   # format.js
    # end
  end

  def show
  	@title = '渠道连接'
    @channelurl = Channelurl.find(params[:id])
  end

  def get_brokers
    @branch = Branch.find params[:branch_id]
    @brokers = @branch.brokers.valid_brokers
  end 
end
