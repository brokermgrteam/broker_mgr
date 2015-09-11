class Schedule < ActiveRecord::Base
  # attr_accessible :title, :body
  def self.task
    Rails.logger.task.info "job sync21tbOrganizes, start ok. #{Time.now}"
  end
end
