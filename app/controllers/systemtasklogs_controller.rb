# encoding: utf-8
class SystemtasklogsController < ApplicationController
	load_and_authorize_resource
	before_filter :authenticate

	def index
    @systemtasklogs = Systemtasklog.all
    @title = "系统状态"
    @tasks = Systemtasklog.tasks.recent
    @online = Session.online.count
    @total_visit = Session.total_visit.count
    @update_date = Systemupgradelog.maximum("update_date").to_date
    @operation_time = TimeDifference.between(Systemupgradelog.maximum("update_date"), Time.now).in_general
  end
end
