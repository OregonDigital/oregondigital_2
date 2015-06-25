RSpec.configure do |config|
  config.include ActiveJob::TestHelper
  config.before :example, perform_enqueued: true do
    @old_perform_enqueued_jobs = ActiveJob::Base.queue_adapter.perform_enqueued_jobs
    @old_perform_enqueued_at_jobs = ActiveJob::Base.queue_adapter.perform_enqueued_at_jobs
    ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true
    ActiveJob::Base.queue_adapter.perform_enqueued_at_jobs = true
  end

  config.after :example, perform_enqueued: true do
    ActiveJob::Base.queue_adapter.perform_enqueued_jobs = @old_perform_enqueued_jobs
    ActiveJob::Base.queue_adapter.perform_enqueued_at_jobs = @old_perform_enqueued_at_jobs
  end
end
