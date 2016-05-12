class Cyber.Models.Build extends Backbone.Model
  paramRoot: 'build'

  defaults:
    session_id: null
    started_by: null
    build_created_at: null
    summary_status: null
    duration: null
    worker_time: null
    bundle_time: null
    num_workers: null
    branch: null
    commit_id: null

class Cyber.Collections.BuildsCollection extends Backbone.Collection
  model: Cyber.Models.Build
  url: '/builds'
