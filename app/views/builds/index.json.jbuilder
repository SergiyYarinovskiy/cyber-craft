json.array!(@builds) do |build|
  json.extract! build, :id, :session_id, :started_by, :build_created_at, :summary_status, :duration, :worker_time, :bundle_time, :num_workers, :branch, :commit_id
  json.url build_url(build, format: :json)
end
