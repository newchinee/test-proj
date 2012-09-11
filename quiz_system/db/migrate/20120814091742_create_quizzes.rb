class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.string :name
      t.text :description
      t.integer :category_id
      t.boolean :random_flag, :default => false
      t.integer :max_question, :default => 100
      t.boolean :deleted_flag, :default => false
      t.integer :time_allowed, :default => 30
      t.boolean :completed, :default => false

      t.timestamps
    end
  end
end
