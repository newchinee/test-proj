class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :registerable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  
  has_many :results, dependent: :destroy
  
  before_save { |user| user.email = email.downcase }
  
  validates :first_name, presence: true, length: { maximum: 32 }
  validates :last_name, presence: true, length: { maximum: 32 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  
  def self.sortable_columns
    self.column_names
  end

  def self.search(search)
    if search
      column = %w[first_name last_name email]
      @search_text = "#{column.first} like :search"
      column.each_with_index do |name, index|
        @search_text = "#{@search_text} or #{name} like :search" unless index == 0 
      end
      where(@search_text, search: "%#{search}%")
    else
      scoped
    end
  end
end
