# encoding: utf-8
class BrokersController < ApplicationController
  # include SimpleCalendar


  load_and_authorize_resource
  before_filter :authenticate#, :only => [:index, :show]

  def show
    @broker = Broker.find(params[:id])
    @title  = @broker.broker_code + " - " + @broker.broker_name
    @branch = @broker.branch
    @father_department = @branch.department
    @salary_months = @broker.brokerindices.limit(3).where(:indextype => 2009).reverse_order
    @workflowunderways = Workflowunderway.where(:user_id => @broker.user_id).limit(5).order('created_at desc')
    @brokerproducts = @broker.products
    @newproducts = Product.find(:all, :order => "id desc", :limit => 10)

    @usersigns = @broker.user.usersigns

    @brokerfavcusts_grid = initialize_grid(Cust,
              :conditions => { :id => @broker.brokerfavcusts.map{|c| c.cust_id} },
              :include => [:custindices],
              # :name => 'brokerfavcusts',
              :per_page => 5)

    @brokercompliance_grid = initialize_grid(Brokercompliancelog,
              :order => 'brokercompliancelogs.month_id',
              :order_direction => 'desc',
              :conditions => {:broker_id => @broker},
              :per_page => 5)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @broker }
    end
  end

  def index
    # @brokers = Broker.all
    @brokers_grid = initialize_grid(Broker,
              :order => 'brokers.broker_code',
              # :order_direction => 'desc',
              :conditions => {:branch_id => Branch.accessible_by(current_ability).map{|br| [br.id]}},
              :include => [:branch],
              :name => 'brokers',
              :enable_export_to_csv => true,
              :csv_field_separator => ';',
              :csv_file_name => '导出',
              :per_page => 20)
    @title = "营销人员"
    export_grid_if_requested('brokers' => 'grid')
  end

  def relbrokers
    @title = "关联帐户"
    @broker = Broker.find(params[:id])
    @brokers = @broker.relbrokers
    render 'categories/search'
  end

  def teambrokers
    @broker = Broker.find(params[:id])
    @teambrokers = @broker.teambrokers

    respond_to do |format|
      format.html
      format.js
    end
  end

  def brokerteam
    @broker = Broker.find(params[:id])
    @manager = [Broker.find(Brokerteamrel.find_by_lower_broker_id(@broker).broker_id)]

    respond_to do |format|
      format.html
      format.js
    end
  end

  def leaveteam
    @membership = Brokerteamrel.find_by_lower_broker_id(params[:id])
    @teambroker = current_broker
    @leader = Broker.find(@membership.broker_id)

    @membership.update_attribute :status, get_dict("BrokerTeamrel.status", 1).id
    @brokerteammodify = Brokerteammodify.create(:broker_id => @membership.broker_id,
                                                :memo => "申请解除" + @teambroker.broker_code + "-" + @teambroker.broker_name + "团队成员身份",
                                                :modify_type => get_dict('BrokerTeam.modify', 2).id,
                                                :status => get_dict('BrokerTeam.opinion', 0).id,
                                                :user_id => current_user.id)
    @massage = Massage.create(:content => "团队成员" + @teambroker.broker_code + "-" + @teambroker.broker_name + "申请离开团队",
                              :messenger_id => current_user.id,
                              :title => "团队人员申请退出",
                              :user_id => @leader.user.id,
                              :status => false)
    if (@massage.save && @brokerteammodify.save)
      respond_to do |format|
        format.html
        format.js
      end
    else
      redirect_to root_path, :flash => { :error => "团队关系解除失败"}
    end
  end

  def removeteambroker
    # @broker = Broker.find(params[:lower_broker_id])
    @membership = Brokerteamrel.find_by_lower_broker_id(params[:id])
    @teambroker = Broker.find(params[:id])
    @teammodifyhis = Brokerteammodify.find(:first, :conditions => ["user_id = ? AND modify_type = ? AND status <> ? AND to_char(created_at,'YYYYMM') = ?", current_user.id, get_dict('BrokerTeam.modify', 2).id, get_dict('BrokerTeam.opinion', 2).id, Time.now.strftime("%Y%m")])

    if @teammodifyhis.nil?
      @membership.update_attribute :status, get_dict("BrokerTeamrel.status", 1).id
      @brokerteammodify = Brokerteammodify.create(:broker_id => @membership.broker_id,
                                                  :memo => "申请解除" + @teambroker.broker_code + "-" + @teambroker.broker_name + "团队成员身份",
                                                  :modify_type => get_dict('BrokerTeam.modify', 2).id,
                                                  :status => get_dict('BrokerTeam.opinion', 0).id,
                                                  :user_id => current_user.id)
      @massage = Massage.create(:content => "团队长已申请解除" + @teambroker.broker_code + "-" + @teambroker.broker_name + "团队成员身份",
                                :messenger_id => current_user.id,
                                :title => "团队人员关系解除通知",
                                :user_id => @teambroker.user.id,
                                :status => false)
      if (@massage.save && @brokerteammodify.save)
        respond_to do |format|
          format.html
          format.js
        end
      else
        redirect_to root_path, :flash => { :error => "团队关系解除失败"}
      end
    else
      respond_to do |format|
        format.js { render :action => 'refuse.js.erb'}
      end
    end
  end
end
