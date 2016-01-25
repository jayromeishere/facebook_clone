class Comment < ActiveRecord::Base
  validates :commenter_id, :post_id,
    presence: true,
    numericality: true
  validates :text,
    presence: true
  
  has_many :notifications,
    as: :source
  belongs_to :commenter, 
    class_name: "User"
  belongs_to :post
  has_many :likes,
    as: :likeable,
    dependent: :destroy
  has_many :likers,
    through: :likes,
    class_name: "User",
    foreign_key: :id
    
end
