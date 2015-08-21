# require 'rufus-scheduler'
#
# if Rails.env.development?
#   Rails.configuration.after_initialize do
#     s = Rufus::Scheduler.singleton
#     s.every '1m' do
#       # @task = Systemtasklog.new(:task_date => Time.now, :total_tasks => 1, :complete_tasks => 1, :task_type => Dict.find_by_dict_type_and_code('Task.type',3).id)
#       # @task.save
#       Rails.logger.task.info "#{@task}, ok. #{Time.now}"
#     end
#   end
# end
#
# if Rails.env.production?
#   Rails.configuration.after_initialize do
#     # Let's use the rufus-scheduler singleton
#     #
#     s = Rufus::Scheduler.singleton
#
#     # s.every '1d' do
#     #   # Recurring.empty21tbOrganizes
#     #   api = APP_CONFIG['21tb_api']
#     #   uri = APP_CONFIG['21tb_uri_removeOrganizes']
#     #   current_api = api + uri + ".html"
#     #   appkey = APP_CONFIG['21tb_appkey']
#     #   secrect = APP_CONFIG['21tb_secrect']
#     #   corpcode = APP_CONFIG['21tb_corpcode']
#     #   signText = secrect + "|" + uri + "|" + secrect
#     #   sign = Digest::MD5.hexdigest(signText).upcase
#     #   timeStamp = DateTime.now.strftime('%Q')
#     #
#     #   a = { 'appKey_' => appkey,
#     #         'sign_' => sign,
#     #         'timestamp_' => timeStamp }
#     #
#     #   # x = Net::HTTP.post_form(URI.parse(current_api), a)
#     #   # x.code
#     #
#     #
#     #   http_client = Net::HTTP.new(URI.parse(current_api).host, URI.parse(current_api).port)
#     #   # http_client.verify_mode = OpenSSL::SSL::VERIFY_NONE
#     #   # http_client.use_ssl = true
#     #
#     #   timeout = 240
#     #   http_client.read_timeout = timeout
#     #
#     #   begin
#     #     Timeout::timeout(timeout) do
#     #       http_client.start do |http|
#     #         req = Net::HTTP::Post.new(URI.parse(current_api))
#     #         req.form_data = a
#     #         resp = http.request(req)
#     #       end
#     #     end
#     #     ensure
#     #       http_client.finish rescue nil
#     #   end
#     #
#     #   Rails.logger.task.info "job empty21tbOrganizes, ok. #{Time.now}"
#     #   # puts 'ok'
#     # end
#
#     s.every '1d' do
#       @branches = Branch.all
#       @departments = Department.all
#       api = APP_CONFIG['21tb_api']
#       uri = APP_CONFIG['21tb_uri_syncOrganizes']
#       current_api = api + uri + ".html"
#       appkey = APP_CONFIG['21tb_appkey']
#       secrect = APP_CONFIG['21tb_secrect']
#       corpcode = APP_CONFIG['21tb_corpcode']
#       signText = secrect + "|" + uri + "|" + secrect
#       sign = Digest::MD5.hexdigest(signText).upcase
#       timeStamp = DateTime.now.strftime('%Q')
#
#       l = []
#       @departments.each do |d|
#         h = Hash.new
#         h[:corpCode] = corpcode
#         h[:organizeCode] = d.code
#         h[:organizeName] = d.name.strip
#         h[:parentCode] = "*"
#         l << h
#       end
#       @branches.each do |b|
#         h = Hash.new
#         h[:corpCode] = corpcode
#         h[:organizeCode] = b.code
#         h[:organizeName] = b.name.strip
#         h[:parentCode] = b.department.code
#         l << h
#       end
#
#       a = { 'appKey_' => appkey,
#             'sign_' => sign,
#             'timestamp_' => timeStamp,
#             'organizes' => l.to_json }
#
#       http_client = Net::HTTP.new(URI.parse(current_api).host, URI.parse(current_api).port)
#       # http_client.verify_mode = OpenSSL::SSL::VERIFY_NONE
#       # http_client.use_ssl = true
#
#       timeout = 240
#       http_client.read_timeout = timeout
#
#       begin
#         Timeout::timeout(timeout) do
#           http_client.start do |http|
#             req = Net::HTTP::Post.new(URI.parse(current_api))
#             req.form_data = a
#             resp = http.request(req)
#           end
#         end
#         ensure
#           http_client.finish rescue nil
#       end
#       Rails.logger.task.info "job sync21tbOrganizes, ok. #{Time.now}"
#     end
#
#     s.every '1d' do
#       api = APP_CONFIG['21tb_api']
#       uri = APP_CONFIG['21tb_uri_syncPositions']
#       current_api = api + uri + ".html"
#       appkey = APP_CONFIG['21tb_appkey']
#       secrect = APP_CONFIG['21tb_secrect']
#       corpcode = APP_CONFIG['21tb_corpcode']
#       signText = secrect + "|" + uri + "|" + secrect
#       sign = Digest::MD5.hexdigest(signText).upcase
#       timeStamp = DateTime.now.strftime('%Q')
#
#       l = []
#       h = Hash.new
#       h[:corpCode] = corpcode
#       h[:positionCode] = "1"
#       h[:positionName] = "A类经纪人"
#       h[:categoryCode] = "01"
#       h[:categoryName] = "证券经纪人"
#       l << h
#
#       h = Hash.new
#       h[:corpCode] = corpcode
#       h[:positionCode] = "2"
#       h[:positionName] = "B类经纪人"
#       h[:categoryCode] = "01"
#       h[:categoryName] = "证券经纪人"
#       l << h
#
#       h = Hash.new
#       h[:corpCode] = corpcode
#       h[:positionCode] = "3"
#       h[:positionName] = "C类经纪人"
#       h[:categoryCode] = "01"
#       h[:categoryName] = "证券经纪人"
#       l << h
#
#       a = { 'appKey_' => appkey,
#             'sign_' => sign,
#             'timestamp_' => timeStamp,
#             'positions' => l.to_json }
#
#       http_client = Net::HTTP.new(URI.parse(current_api).host, URI.parse(current_api).port)
#       # http_client.verify_mode = OpenSSL::SSL::VERIFY_NONE
#       # http_client.use_ssl = true
#
#       timeout = 240
#       http_client.read_timeout = timeout
#
#       begin
#         Timeout::timeout(timeout) do
#           http_client.start do |http|
#             req = Net::HTTP::Post.new(URI.parse(current_api))
#             req.form_data = a
#             resp = http.request(req)
#           end
#         end
#         ensure
#           http_client.finish rescue nil
#       end
#       Rails.logger.task.info "job syncPositions, ok. #{Time.now}"
#     end
#
#     s.every '12h' do
#       @branches = Branch.all
#
#       @branches.each do |br|
#         @brokers = br.brokers.where('broker_type = ? and broker_status <> ? and broker_name not like ?', 4119, 407, "离职%")
#         if @brokers.count > 0
#           api = APP_CONFIG['21tb_api']
#           uri = APP_CONFIG['21tb_uri_syncUsers']
#           current_api = api + uri + ".html"
#           appkey = APP_CONFIG['21tb_appkey']
#           secrect = APP_CONFIG['21tb_secrect']
#           corpcode = APP_CONFIG['21tb_corpcode']
#           signText = secrect + "|" + uri + "|" + secrect
#           sign = Digest::MD5.hexdigest(signText).upcase
#           timeStamp = DateTime.now.strftime('%Q')
#
#           l = []
#           @brokers.each do |b|
#             h = Hash.new
#             h[:corpCode] = corpcode
#             h[:userName] = b.broker_name.strip
#             h[:employeeCode] = b.broker_code
#             h[:loginName] = b.broker_code
#             h[:organizeCode] = b.branch.code || '0000'
#             h[:accountStatus] = (Dict.find(b.broker_status).code == 2) ? 'FORBIDDEN' : 'ENABLE'
#             h[:positionCode] = Dict.find(b.broker_level).code.to_s if b.broker_level
#             h[:email] = b.email if b.email
#             h[:idCard] = b.certificate_num if b.certificate_num
#             l << h
#           end
#
#           a = { 'appKey_' => appkey,
#                 'sign_' => sign,
#                 'timestamp_' => timeStamp,
#                 'users' => l.to_json,
#                 'updatePswFirstLogin' => true}
#
#           http_client = Net::HTTP.new(URI.parse(current_api).host, URI.parse(current_api).port)
#
#           timeout = 600
#           http_client.read_timeout = timeout
#
#           begin
#             Timeout::timeout(timeout) do
#               http_client.start do |http|
#                 req = Net::HTTP::Post.new(URI.parse(current_api))
#                 req.form_data = a
#                 resp = http.request(req)
#               end
#             end
#             ensure
#               http_client.finish rescue nil
#           end
#         end
#       end
#       Rails.logger.task.info "job syncUsers, ok. #{Time.now}"
#     end
#
#     s.every '1d' do
#       api = APP_CONFIG['21tb_api']
#       uri = APP_CONFIG['21tb_uri_getReportList']
#       current_api = api + uri + ".html"
#       appkey = APP_CONFIG['21tb_appkey']
#       secrect = APP_CONFIG['21tb_secrect']
#       corpcode = APP_CONFIG['21tb_corpcode']
#       signText = secrect + "|" + uri + "|" + secrect
#       sign = Digest::MD5.hexdigest(signText).upcase
#       timeStamp = DateTime.now.strftime('%Q')
#       startTime = DateTime.now
#       endTime = DateTime.now
#
#
#       h = Hash.new
#       h[:employeeCodes] = nil
#       h[:courseCodes] = nil
#       h[:startTime] = (Time.now-31.days).to_s
#       h[:endTime] = Time.now.to_s
#
#
#       a = { 'appKey_' => appkey,
#             'sign_' => sign,
#             'timestamp_' => timeStamp,
#             'courseReportQuery' => h.to_json }
#
#       # x = Net::HTTP.post_form(URI.parse(current_api), a)
#       # JSON.parse(x.body)
#       http_client = Net::HTTP.new(URI.parse(current_api).host, URI.parse(current_api).port)
#       # http_client.verify_mode = OpenSSL::SSL::VERIFY_NONE
#       # http_client.use_ssl = true
#
#       timeout = 240
#       http_client.read_timeout = timeout
#
#       begin
#         Timeout::timeout(timeout) do
#           http_client.start do |http|
#             req = Net::HTTP::Post.new(URI.parse(current_api))
#             req.form_data = a
#             resp = http.request(req)
#             j = JSON.parse(resp.body)
#             j.each do |b|
#               @brokercoursereport = Brokercoursereport.new(:course_code => b["courseCode"],
#                                                            :course_finish_time => Date.strptime((b["courseFinishTime"].to_f / 1000).to_s, '%s'),
#                                                            :course_name => b["courseName"],
#                                                            :course_period => b["coursePeriod"],
#                                                            :course_score => b["courseScore"],
#                                                            :employee_code => b["employeeCode"],
#                                                            :plan_start_time => Date.strptime((b["planStartTime"].to_f / 1000).to_s, '%s'),
#                                                            :step_to_get_score => b["stepToGetScore"],
#                                                            :user_name => b["userName"])
#               @brokercoursereport.save
#             end
#           end
#         end
#         ensure
#           http_client.finish rescue nil
#       end
#       Rails.logger.task.info "job getReports, ok. #{Time.now}"
#     end
#
#     s.every '1d' do
#       api = APP_CONFIG['21tb_api']
#       uri = APP_CONFIG['21tb_uri_getExamReportList']
#       current_api = api + uri + ".html"
#       appkey = APP_CONFIG['21tb_appkey']
#       secrect = APP_CONFIG['21tb_secrect']
#       corpcode = APP_CONFIG['21tb_corpcode']
#       signText = secrect + "|" + uri + "|" + secrect
#       sign = Digest::MD5.hexdigest(signText).upcase
#       timeStamp = DateTime.now.strftime('%Q')
#       startTime = (Time.now-31.days).to_s
#       endTime = Time.now.to_s
#
#
#       h = Hash.new
#       h[:employeeCodes] = nil
#       h[:examCodes] = nil
#       h[:startTime] = startTime
#       h[:endTime] = endTime
#
#
#       a = { 'appKey_' => appkey,
#             'sign_' => sign,
#             'timestamp_' => timeStamp,
#             'reportQuery' => h.to_json }
#
#       # x = Net::HTTP.post_form(URI.parse(current_api), a)
#       # JSON.parse(x.body)
#       http_client = Net::HTTP.new(URI.parse(current_api).host, URI.parse(current_api).port)
#       # http_client.verify_mode = OpenSSL::SSL::VERIFY_NONE
#       # http_client.use_ssl = true
#
#       timeout = 240
#       http_client.read_timeout = timeout
#
#       begin
#         Timeout::timeout(timeout) do
#           http_client.start do |http|
#             req = Net::HTTP::Post.new(URI.parse(current_api))
#             req.form_data = a
#             resp = http.request(req)
#             j = JSON.parse(resp.body)
#             j.each do |b|
#               @brokerexam = Brokerexam.new(b)
#               @brokerexam.save
#             end
#           end
#         end
#         ensure
#           http_client.finish rescue nil
#       end
#       Rails.logger.task.info "job getExams, ok. #{Time.now}"
#     end
#
#     # s.every '1d' do
#     #   api = APP_CONFIG['21tb_api']
#     #   uri = APP_CONFIG['21tb_uri_getExamInvigilates']
#     #   current_api = api + uri + ".html"
#     #   appkey = APP_CONFIG['21tb_appkey']
#     #   secrect = APP_CONFIG['21tb_secrect']
#     #   corpcode = APP_CONFIG['21tb_corpcode']
#     #   signText = secrect + "|" + uri + "|" + secrect
#     #   sign = Digest::MD5.hexdigest(signText).upcase
#     #   timeStamp = DateTime.now.strftime('%Q')
#     #   startTime = (Time.now-31.days).to_s
#     #   endTime = Time.now.to_s
#     #
#     #
#     #   h = Hash.new
#     #   h[:employeeCodes] = nil
#     #   h[:examCodes] = nil
#     #   h[:startTime] = startTime
#     #   h[:endTime] = endTime
#     #
#     #
#     #   a = { 'appKey_' => appkey,
#     #         'sign_' => sign,
#     #         'timestamp_' => timeStamp,
#     #         'reportQuery' => h.to_json }
#     #
#     #   # x = Net::HTTP.post_form(URI.parse(current_api), a)
#     #   # JSON.parse(x.body)
#     #   http_client = Net::HTTP.new(URI.parse(current_api).host, URI.parse(current_api).port)
#     #   # http_client.verify_mode = OpenSSL::SSL::VERIFY_NONE
#     #   # http_client.use_ssl = true
#     #
#     #   timeout = 240
#     #   http_client.read_timeout = timeout
#     #
#     #   begin
#     #     Timeout::timeout(timeout) do
#     #       http_client.start do |http|
#     #         req = Net::HTTP::Post.new(URI.parse(current_api))
#     #         req.form_data = a
#     #         resp = http.request(req)
#     #         j = JSON.parse(resp.body)
#     #         j.each do |b|
#     #           @brokerexam = Brokerexam.new(b)
#     #           @brokerexam.save
#     #         end
#     #       end
#     #     end
#     #     ensure
#     #       http_client.finish rescue nil
#     #   end
#     #   Rails.logger.task.info "job getExams, ok. #{Time.now}"
#     # end
#   end
# end