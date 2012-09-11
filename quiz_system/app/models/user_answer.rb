class UserAnswer < ActiveRecord::Base
  attr_accessible :answer_id, :question_id, :quiz_id, :user_id
end
