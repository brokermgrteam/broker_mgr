# encoding: utf-8
class Schedule < ActiveRecord::Base
  # attr_accessible :title, :body
  def self.task_user
    Rails.logger.task.info "job syncUsers, start ok. #{Time.now}"
      @brokers = Broker.where('updated_at >= (sysdate - 7) and broker_type = ? and broker_status <> ? and broker_name not like ?', 4119, 407, "离职%")
      if @brokers.count > 0
        api = APP_CONFIG['21tb_api']
        uri = APP_CONFIG['21tb_uri_syncUsers']
        current_api = api + uri + ".html"
        appkey = APP_CONFIG['21tb_appkey']
        secrect = APP_CONFIG['21tb_secrect']
        corpcode = APP_CONFIG['21tb_corpcode']
        signText = secrect + "|" + uri + "|" + secrect
        sign = Digest::MD5.hexdigest(signText).upcase
        timeStamp = DateTime.now.strftime('%Q')

        l = []
        @brokers.each do |b|
          h = Hash.new
          h[:corpCode] = corpcode
          h[:userName] = b.broker_name.strip
          h[:employeeCode] = b.broker_code
          h[:loginName] = b.broker_code
          h[:organizeCode] = b.branch.code || '0000'
          h[:accountStatus] = (Dict.find(b.broker_status).code == 2) ? 'FORBIDDEN' : 'ENABLE'
          h[:positionCode] = Dict.find(b.broker_level).code.to_s if b.broker_level
          h[:email] = b.email if b.email
          h[:idCard] = b.certificate_num if b.certificate_num
          l << h
        end

        a = { 'appKey_' => appkey,
              'sign_' => sign,
              'timestamp_' => timeStamp,
              'users' => l.to_json,
              'updatePswFirstLogin' => true}

        http_client = Net::HTTP.new(URI.parse(current_api).host, URI.parse(current_api).port)
        Rails.logger.task.info "job syncUsers, #{@brokers.count.to_s} users get ok. #{Time.now}"

        timeout = 600
        http_client.read_timeout = timeout

        begin
          Timeout::timeout(timeout) do
            http_client.start do |http|
              req = Net::HTTP::Post.new(URI.parse(current_api))
              req.form_data = a
              resp = http.request(req)
              Rails.logger.task.info "job syncUsers, users push respond #{resp.code}. #{Time.now}"
            end
          end
          ensure
            http_client.finish
        end
      end
    Rails.logger.task.info "job syncUsers, finished. #{Time.now}"
  end

  def self.task_branches
    Rails.logger.task.info "job syncOrganizes, start ok. #{Time.now}"
    @branches = Branch.all
    @departments = Department.all
    api = APP_CONFIG['21tb_api']
    uri = APP_CONFIG['21tb_uri_syncOrganizes']
    current_api = api + uri + ".html"
    appkey = APP_CONFIG['21tb_appkey']
    secrect = APP_CONFIG['21tb_secrect']
    corpcode = APP_CONFIG['21tb_corpcode']
    signText = secrect + "|" + uri + "|" + secrect
    sign = Digest::MD5.hexdigest(signText).upcase
    timeStamp = DateTime.now.strftime('%Q')

    l = []
    @departments.each do |d|
      h = Hash.new
      h[:corpCode] = corpcode
      h[:organizeCode] = d.code
      h[:organizeName] = d.name.strip
      h[:parentCode] = "*"
      l << h
    end
    @branches.each do |b|
      h = Hash.new
      h[:corpCode] = corpcode
      h[:organizeCode] = b.code
      h[:organizeName] = b.name.strip
      h[:parentCode] = b.department.code
      l << h
    end

    a = { 'appKey_' => appkey,
          'sign_' => sign,
          'timestamp_' => timeStamp,
          'organizes' => l.to_json }

    http_client = Net::HTTP.new(URI.parse(current_api).host, URI.parse(current_api).port)
    # http_client.verify_mode = OpenSSL::SSL::VERIFY_NONE
    # http_client.use_ssl = true

    timeout = 240
    http_client.read_timeout = timeout

    begin
      Timeout::timeout(timeout) do
        http_client.start do |http|
          req = Net::HTTP::Post.new(URI.parse(current_api))
          req.form_data = a
          resp = http.request(req)
        end
      end
      ensure
        http_client.finish rescue nil
    end
    Rails.logger.task.info "job sync21tbOrganizes, ok. #{Time.now}"
  end
end
# == Schema Information
#
# Table name: schedules
#
#  id         :integer(38)     not null, primary key
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

