class Category < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :quizzes
  
  validates :name, presence: true, length: { maximum: 64 }
  validates :description, length: { maximum: 255 }
  
  def self.sortable_columns
    self.column_names
  end
  
  def self.search(search)
    if search
      where("name like :search or description like :search", search: "%#{search}%")
    else
      scoped
    end
  end
end
