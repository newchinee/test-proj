class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :name
      t.integer :quiz_id
      t.integer :score, :default => 1
      t.boolean :deleted_flag, :default => false

      t.timestamps
    end
  end
end
