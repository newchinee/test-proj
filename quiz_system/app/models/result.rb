class Result < ActiveRecord::Base
  attr_accessible :comment, :end_time, :marks, :quiz_id, :retry_count, :start_time, :user_id, :time_taken, :status, :resume_time
  scope :by_user, lambda {|id| {:conditions => {:user_id => id}}}
  scope :by_quiz, lambda {|id| {:conditions => {:quiz_id => id}}}

  belongs_to :user
  belongs_to :quiz
  
  validates :marks, presence: true
  validates_numericality_of :marks, :only_integer => true
  validates_inclusion_of :marks, :in => 0..100
  validates :comment, length: { maximum: 255 }
  validates_numericality_of :status, :only_integer => true
  validates_inclusion_of :status, :in => 0..3
  
  #Constants
  STATUS_STARTED = 0
  STATUS_PAUSE = 1
  STATUS_RESUME = 2
  STATUS_ENDED = 3
  
  def self.sortable_columns
    columns = self.column_names.dup
    columns + %w[users.first_name quizzes.name]
  end
  
  def self.search(search)
    if search
      column = %w[users.first_name users.last_name quizzes.name comment marks retry_count]
      @search_text = "#{column.first} like :search"
      column.each_with_index do |name, index|
        @search_text = "#{@search_text} or #{name} like :search" unless index == 0 
      end
      where(@search_text, search: "%#{search}%")
    else
      scoped
    end
  end
    
  def self.filter_by_quiz(id)
    if id && id != '-1'
      by_quiz(id)
    else
      scoped
    end
  end
  
  def self.filter_by_user(id)
    if id && id != '-1'
      by_user(id)
    else
      scoped
    end
  end
  
end
