module Importer
  class << self
    def import_csv_to_build(file)
      return unless file && file.content_type =~ /csv/
      csv = CSV.parse(File.read(file.path), headers: true)
      builds = []
      csv.each do |row|
        attributes = row.to_hash
        build = Build.new(attributes.slice(*builds_valid_attr))
        build.build_created_at = attributes['created_at']
        builds << build if build.valid?
      end
      Build.import(builds)
      true
    rescue
      false
    end

    private

    def builds_valid_attr
      %w(
        session_id started_by summary_status duration worker_time
        bundle_time num_workers branch commit_id started_tests_count
        passed_tests_count failed_tests_count pending_tests_count
        skipped_tests_count error_tests_count
      )
    end
  end
end # Importer
