class Like < ActiveRecord::Base
  validates :liker_id, :likeable_id,
    presence: true,
    numericality: true
  validates :likeable_type,
    presence: true, 
    inclusion: { in: ["Comment", "Post"] }
    
  belongs_to :likeable,
    polymorphic: true
  belongs_to :post
  belongs_to :comment
  belongs_to :liker,
    class_name: "User"
  has_many :notifications, 
    as: :source,
    dependent: :destroy
end
