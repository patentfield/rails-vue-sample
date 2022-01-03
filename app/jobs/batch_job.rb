class BatchJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: 0

  sidekiq_retries_exhausted do |msg, e|
    raise RuntimeError, "Counldn't execute batch process"
  end

  def perform(user_id, params)
    user = User.find(user_id)
    raise ArgumentError, 'Not found user' if user.nil?
    Job.find_or_create_by(
      user: user,
      params: params.to_s,
      job_id: self.job_id,
      status: "executing"
    )
    sleep(5)

    if job = Job.find_by(user: user, job_id: self.job_id)
      job.status = "success" if job.status != "failed"
      job.save
    end
    Notification.to(user, "finished bach job #{self.job_id}")
  end
end
