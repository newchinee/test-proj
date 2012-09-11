class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :user_id
      t.integer :quiz_id
      t.timestamp :start_time
      t.timestamp :end_time
      t.integer :marks
      t.text :comment
      t.integer :retry_count, :default => 0
      t.integer :time_taken, :default => 0
      t.integer :status, :default => 0 

      t.timestamps
    end
  end
end
