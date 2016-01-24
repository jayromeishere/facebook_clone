class Post < ActiveRecord::Base
  validates :poster_id, 
    presence: true,
    numericality: true
  validates :text,
    presence: true
    
  belongs_to :poster, 
    class_name: "User"
  has_many :comments, 
    dependent: :destroy
  

end
