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
  has_many :likes,
    as: :likeable,
    dependent: :destroy
  has_many :likers,
    through: :likes,
    class_name: "User",
    foreign_key: :id

end
