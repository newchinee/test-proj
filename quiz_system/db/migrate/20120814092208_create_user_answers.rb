class CreateUserAnswers < ActiveRecord::Migration
  def change
    create_table :user_answers do |t|
      t.integer :user_id
      t.integer :quiz_id
      t.integer :question_id
      t.integer :answer_id
      t.string  :session_id
      t.boolean :completed_flag
      t.timestamps
    end
  end
end
