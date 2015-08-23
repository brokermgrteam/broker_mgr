require 'rufus/scheduler'
class Scheduler

  # Starts the scheduler unless it is already running
  def self.start_unless_running(pid_file)
    with_lockfile(File.join(File.dirname(pid_file), 'scheduler.lock')) do
      if File.exists?(pid_file)
        pid = IO.read(pid_file).to_i
        if pid > 0 && process_running?(pid)
          Rails.logger.task.info "not starting scheduler because it already is running with pid #{pid}"
        else
          Rails.logger.task.info "Process #{$$} removes stale pid file"
          File.delete pid_file
        end
      end

      if !File.exists?(pid_file)
        # Write the current PID to the file
        (File.new(pid_file,'w') << $$).close
        Rails.logger.task.info "scheduler process is: #{$$}"

        # Execute the scheduler
        new.setup_jobs
      end
      true
    end or Rails.logger.task.info "could not start scheduler - lock not acquired"
  end

  # true if the process with the given PID exists, false otherwise
  def self.process_running?(pid)
    Process.kill(0, pid)
    true
  rescue Exception
    false
  end

  # executes the given block if the lock can be acquired, otherwise nothing is
  # done and false returned.
  def self.with_lockfile(lock_file)
    lock = File.new(lock_file, 'w')
    begin
      if lock.flock(File::LOCK_EX | File::LOCK_NB)
        yield
      else
        return false
      end
    ensure
      lock.flock(File::LOCK_UN)
      File.delete lock
    end
  end

  def initialize
    @rufus_scheduler = Rufus::Scheduler.new
    # install exception handler to report errors via Airbrake
    @rufus_scheduler.class_eval do
      define_method :handle_exception do |job, exception|
        Rails.logger.task.info "job #{job.job_id} caught exception '#{exception}'"
        Airbrake.notify exception
      end
    end
  end

  #
  # Job-Definitions go here
  #
  def setup_jobs
    @rufus_scheduler.every('1m') do
      Rails.logger.task.info "job start, ok. #{Time.now}"
    end
    @rufus_scheduler.every('30s') do
      Rails.logger.task.info "job 2 start, ok. #{Time.now}"
    end
    Rails.logger.task.info "job done, ok. #{Time.now}"
  end

end
