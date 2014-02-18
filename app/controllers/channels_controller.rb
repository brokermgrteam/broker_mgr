# encoding: utf-8
class ChannelsController < ApplicationController
	load_and_authorize_resource
	before_filter :authenticate, :only => [:index, :show, :edit, :update]


end
