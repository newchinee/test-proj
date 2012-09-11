class Quiz < ActiveRecord::Base
  attr_accessible :category_id, :deleted_flag, :description, :max_question, :name, :random_flag, :time_allowed, :completed, :questions_attributes
  has_many :questions, :dependent => :destroy
  # accepts_nested_attributes_for :questions, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :questions, :allow_destroy => true
  belongs_to :category
  has_many :results
  
  validates :category_id, :time_allowed, presence: true
  validates :name, presence: true, length: { maximum: 64 }
  validates :description, length: { maximum: 255 }
  validates_numericality_of :max_question, :only_integer => true
  validates_numericality_of :time_allowed, :only_integer => true, :greater_than => 0
  
  # Override destroy
  def destroy    
    run_callbacks :destroy do
      self.deleted_flag = true
      save
    end
  end
  
  def self.sortable_columns
    columns = self.column_names.dup
    columns + %w[categories.name]
  end
  
  def self.search(search)
    if search
      where(:deleted_flag => false).where("quizzes.name like :search or quizzes.description like :search", search: "%#{search}%")
    else
      where(:deleted_flag => false)
    end
  end
  
  def category_name
    begin
      category = Category.find(self.category_id)
      category.name
    rescue ActiveRecord::RecordNotFound
      "[#{self.category_id}]"
    end
  end
  
  def update_answer_score
    self.questions.each do |question|
      question.answers.each do |answer|
        if(answer.correct_flag)
          answer.score = question.score
        else
          answer.score = 0
        end 
      end
    end
    save
  end
  
  def update_time_allowed(hours, minutes)
    self.time_allowed = (hours * 60) + minutes
  end
  
  def update_completeness
    self.completed = false
    
    # quiz must have min of 1 question
    if(self.count_non_deleted(self.questions) <= 0)
      save
      return
    end
    
    self.questions.each do |question|
      if(!question.deleted_flag)  
        
        # min answers for each question is 2
        if(self.count_non_deleted(question.answers) <= 1)
          save
          return
        end
      
        answer_found = false;
        # each question must have a correct answer
        question.answers.each do |answer|
          if(!answer.deleted_flag && answer.correct_flag)
            answer_found = true
            break
          end
        end
        if(!answer_found)
          save
          return
        end
      
      end
    end
    
    self.completed = true
    save
  end
  
  def count_non_deleted(collection)
    count = 0
    collection.each do |item|
      count += 1 unless(item.deleted_flag)
    end
    puts(count)
    count
  end
  
  def self.find_completed_quiz_by_category(id)
    where("deleted_flag = ? and completed = ? and category_id = ?", false, true, id)
  end
  
end
