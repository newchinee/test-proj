class Answer < ActiveRecord::Base
  attr_accessible :correct_flag, :deleted_flag, :name, :explanation, :question_id, :score
  
  belongs_to :question
  
  validates :name, presence: true, length: { maximum: 255 }
  validates :explanation, length: { maximum: 255 }
  validates :score, presence: true
  validates_numericality_of :score, :only_integer => true
  
  def destroy
    run_callbacks :destroy do
      self.deleted_flag = true
      save
    end
  end
end
