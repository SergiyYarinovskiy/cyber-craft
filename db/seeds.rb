100.times do
  Build.create(
    session_id: rand(100),
    started_by: 'admin',
    build_created_at: Time.now.utc - rand(20).days,
    summary_status: [Build::PASSED, Build::FAILED, Build::ERROR].sample,
    duration: rand(1000),
    worker_time: rand(100)
  )
end
