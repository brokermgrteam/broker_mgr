# encoding: utf-8
class ChannelurlsController < ApplicationController
	require "uri"
  require "net/http"

  def new
    @title = "获取渠道连接"
  end
    
  def create
  	params = {'box1' => 'Nothing is less important than which fork you use. Etiquette is the science of living. It embraces everything. It is ethics. It is honor. -Emily Post',
    'button1' => 'Submit'
    }
    x = Net::HTTP.post_form(URI.parse('http://www.google.com'), params)
    @url = x.body

    render channelurl_path(@url)
    # respond_to do |format|
    #   format.html { redirect_to @url, :flash => { :success => "URL获取成功" } }
    #   # format.js
    # end
  end

  def show
  	@title = ''

  end
end
