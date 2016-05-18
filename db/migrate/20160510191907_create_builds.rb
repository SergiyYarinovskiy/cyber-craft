class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |t|
      t.integer :session_id
      t.string :started_by
      t.datetime :build_created_at
      t.string :summary_status
      t.integer :duration
      t.integer :worker_time
      t.integer :bundle_time
      t.integer :num_workers
      t.string :branch
      t.string :commit_id
      t.integer :started_tests_count
      t.integer :passed_tests_count
      t.integer :failed_tests_count
      t.integer :pending_tests_count
      t.integer :skipped_tests_count
      t.integer :error_tests_count

      t.timestamps null: false
    end
  end
end
