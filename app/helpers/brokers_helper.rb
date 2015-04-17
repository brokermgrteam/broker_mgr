# encoding: utf-8
module BrokersHelper

  def avatar
    # @broker = Broker.find(params[:id])
    if !@broker.avatar.nil?
      image_tag(@broker.avatar, :alt => @broker.broker_name, :size => "90x90" )
    else
      image_tag("nobody.gif", :alt => @broker.broker_name, :size => "90x90" )
    end
  end

  def channelurl
    a = {
    'channel_id' => Channel.find_by_channel_code("9999"),
    'channel_code' => Channel.find_by_channel_code("9999").channel_code,
    'channel_name' => Channel.find_by_channel_code("9999").channel_code,
    'institution_id' => Channel.find_by_channel_code("9999").institution_id,
    'institution_code' => Institution.find(Channel.find_by_channel_code("9999").institution_id).institution_code,
    'institution_name' => Institution.find(Channel.find_by_channel_code("9999").institution_id).institution_name,
    'open_branch_id' => @broker.branch,
    'open_branch_code' => (@broker.branch.code unless @broker.branch.nil?),
    'open_branch_name' => (@broker.branch.name unless @broker.branch.nil?),
    'serv_branch_id' => @broker.branch,
    'serv_branch_code' => (@broker.branch.code unless @broker.branch.nil?),
    'serv_branch_name' => (@broker.branch.name unless @broker.branch.nil?),
    'broker_id' => @broker,
    'broker_code' => (@broker unless @broker.nil?),
    'broker_name' => (@broker unless @broker.nil?)
    }
    x = Net::HTTP.post_form(URI.parse(APP_CONFIG['channel_url_generator']), a)
    @url = JSON.parse(x.body)[APP_CONFIG['channel_url_function']]
    # @url = "http://kh.htsec.com"
    @wapurl = @url.gsub 'kh.htsec.com', 'khmobile.htsec.com'
    @barcode = APP_CONFIG['wap_url_barcode']+@wapurl.to_s
    @channelurl = Channelurl.find_or_create_by_url(:channel_id => Channel.find_by_channel_code("9999").id,
                                                   :branch_id =>  @broker.branch.id,
                                                   :serv_branch_id => @broker.branch.id,
                                                   :broker_id => @broker.id,
                                                   :url => @url,
                                                   :wapurl => @wapurl)
    if @channelurl.save
      image_tag(@barcode, :alt => "渠道二维码", :class => "img-rounded")
    end
  end

  def level_detect(month)
    prev_month = (month.to_s + "01").to_date.prev_month.strftime("%Y%m")
    @broker = Broker.find(params[:id])
    @current_level = @broker.brokerindices.where(:indextype => '6001', :month_id => month).first.occursum.to_i
    @previous_level = @broker.brokerindices.where(:indextype => '6001', :month_id => prev_month).last.occursum.to_i
    if @current_level > @previous_level
      image_tag("level_up.gif", :alt => "升级", :size => "110x111" )
    elsif @current_level < @previous_level
      image_tag("level_down.gif", :alt => "降级", :size => "110x111" )
    else
      image_tag("level_remain.gif", :alt => "维持", :size => "110x111" )
    end
  end

  def broker_salary(month)
    @broker = Broker.find(params[:id])
    @broker_salary = @broker.brokerindices.where(:month_id => month)
  end
end
