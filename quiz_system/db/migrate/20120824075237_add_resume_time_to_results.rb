class AddResumeTimeToResults < ActiveRecord::Migration
  def change
    add_column :results, :resume_time, :timestamp
  end
end
