def job_is_complete(job_id)
  waiting = Sidekiq::Queue.new
  working = Sidekiq::Workers.new
  if waiting.find { |job| job.job_id == job_id }
    false
  elsif working.find { |worker, info| info["payload"]["job_id"] == job_id}
    false
  else 
    true
  end 
end 
