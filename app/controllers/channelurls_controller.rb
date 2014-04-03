# encoding: utf-8
class ChannelurlsController < ApplicationController
	require "uri"
  require "net/http"
  require "json"

  def new
    @title = "获取渠道连接"
  end
    
  def create
  	a = {
    'channel_id' => params[:channelurl][:channel],
    'channel_code' => Channel.find(params[:channelurl][:channel]).channel_code,
    'channel_name' => Channel.find(params[:channelurl][:channel]).channel_code,
    'institution_id' => Channel.find(params[:channelurl][:channel]).institution_id,
    'institution_code' => Institution.find(Channel.find(params[:channelurl][:channel]).institution_id).institution_code,
    'institution_name' => Institution.find(Channel.find(params[:channelurl][:channel]).institution_id).institution_name,
    'open_branch_id' => params[:channelurl][:cust_branch],
    'open_branch_code' => Branch.find(params[:channelurl][:cust_branch]).code,
    'open_branch_name' => Branch.find(params[:channelurl][:cust_branch]).name,
    'serv_branch_id' => params[:channelurl][:channel_branch],
    'serv_branch_code' => Branch.find(params[:channelurl][:channel_branch]).code,
    'serv_branch_name' => Branch.find(params[:channelurl][:channel_branch]).name,
    'broker_id' => params[:channelurl][:broker],
    'broker_code' => Broker.find(params[:channelurl][:broker]).broker_code,
    'broker_name' => Broker.find(params[:channelurl][:broker]).broker_name
    }
    x = Net::HTTP.post_form(URI.parse('http://10.10.10.157:29002/CRH-KH8201.action?'), a)
    @url = JSON.parse(x.body)['short_url']
    # @url = "abc"
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
