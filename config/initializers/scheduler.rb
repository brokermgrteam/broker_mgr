require 'rufus-scheduler'

if Rails.env.production?
  Rails.configuration.after_initialize do
    # Let's use the rufus-scheduler singleton
    #
    s = Rufus::Scheduler.singleton

    # s.every '5m' do
    #   # Recurring.empty21tbOrganizes
    #   api = APP_CONFIG['21tb_api']
    #   uri = APP_CONFIG['21tb_uri_removeOrganizes']
    #   current_api = api + uri + ".html"
    #   appkey = APP_CONFIG['21tb_appkey']
    #   secrect = APP_CONFIG['21tb_secrect']
    #   corpcode = APP_CONFIG['21tb_corpcode']
    #   signText = secrect + "|" + uri + "|" + secrect
    #   sign = Digest::MD5.hexdigest(signText).upcase
    #   timeStamp = DateTime.now.strftime('%Q')
    #
    #   a = { 'appKey_' => appkey,
    #         'sign_' => sign,
    #         'timestamp_' => timeStamp }
    #
    #   # x = Net::HTTP.post_form(URI.parse(current_api), a)
    #   # x.code
    #
    #
    #   http_client = Net::HTTP.new(URI.parse(current_api).host, URI.parse(current_api).port)
    #   # http_client.verify_mode = OpenSSL::SSL::VERIFY_NONE
    #   # http_client.use_ssl = true
    #
    #   timeout = 240
    #   http_client.read_timeout = timeout
    #
    #   begin
    #     Timeout::timeout(timeout) do
    #       http_client.start do |http|
    #         req = Net::HTTP::Post.new(URI.parse(current_api))
    #         req.form_data = a
    #         resp = http.request(req)
    #       end
    #     end
    #     ensure
    #       http_client.finish rescue nil
    #   end
    #
    #   Rails.logger.info "job empty21tbOrganizes, ok. #{Time.now}"
    #   # puts 'ok'
    # end

    s.every '10m' do
      @branches = Branch.all
      @departmenets = Department.all
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
      @departmenets.each do |d|
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
      Rails.logger.info "job sync21tbOrganizes, ok. #{Time.now}"
    end

    s.every '10m' do
      api = APP_CONFIG['21tb_api']
      uri = APP_CONFIG['21tb_uri_syncPositions']
      current_api = api + uri + ".html"
      appkey = APP_CONFIG['21tb_appkey']
      secrect = APP_CONFIG['21tb_secrect']
      corpcode = APP_CONFIG['21tb_corpcode']
      signText = secrect + "|" + uri + "|" + secrect
      sign = Digest::MD5.hexdigest(signText).upcase
      timeStamp = DateTime.now.strftime('%Q')

      l = []
      h = Hash.new
      h[:corpCode] = corpcode
      h[:positionCode] = "10"
      h[:positionName] = "证券经纪人"
      h[:categoryCode] = "01"
      h[:categoryName] = "营销团队"
      l << h

      a = { 'appKey_' => appkey,
            'sign_' => sign,
            'timestamp_' => timeStamp,
            'positions' => l.to_json }

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
      Rails.logger.info "job syncPositions, ok. #{Time.now}"
    end

    s.every '10m' do
      @brokers = Broker.where('broker_type = ? and broker_status <> ? and broker_name not like ?', 4119, 407, "离职%")
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
        h[:positionCode] = '10'
        l << h
      end

      a = { 'appKey_' => appkey,
            'sign_' => sign,
            'timestamp_' => timeStamp,
            'users' => l.to_json,
            'updatePswFirstLogin' => true}

      http_client = Net::HTTP.new(URI.parse(current_api).host, URI.parse(current_api).port)
      # http_client.verify_mode = OpenSSL::SSL::VERIFY_NONE
      # http_client.use_ssl = true

      timeout = 600
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
      Rails.logger.info "job syncPositions, ok. #{Time.now}"
    end
  end
end
