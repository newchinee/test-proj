class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :name
      t.integer :question_id
      t.boolean :correct_flag, :default => false
      t.integer :score, :default => 1
      t.text :explanation
      t.boolean :deleted_flag, :default => false

      t.timestamps
    end
  end
end
