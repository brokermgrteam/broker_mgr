# encoding: utf-8
class ChannelsController < ApplicationController
	load_and_authorize_resource
	before_filter :authenticate, :only => [:index, :show, :edit, :update]

	def index
	  @channels_grid = initialize_grid(Channel, 
	            :order => 'channels.channel_code',
	            :include => [:institution],
	            :name => 'channel',
	            :enable_export_to_csv => false,
	            :per_page => 20)
	  @title = "营销渠道"
	  # export_grid_if_requested('channels' => 'grid')
	end

end
