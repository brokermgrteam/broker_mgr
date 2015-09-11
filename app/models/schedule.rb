class Schedule < ActiveRecord::Base
  # attr_accessible :title, :body
  def self.task
    Rails.logger.task.info "job sync21tbOrganizes, start ok. #{Time.now}"
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
