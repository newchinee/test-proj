class Question < ActiveRecord::Base
  attr_accessible :deleted_flag, :name, :quiz_id, :score, :answers_attributes
  has_many :answers, :dependent => :destroy
  # accepts_nested_attributes_for :answers, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :answers, :allow_destroy => true
  belongs_to :quiz

  validates :name, presence: true, length: { maximum: 255 }
  validates :score, presence: true
  validates_numericality_of :score, :only_integer => true
  
  # Override destroy
  def destroy
    run_callbacks :destroy do
      self.deleted_flag = true
      save
    end
  end
end
