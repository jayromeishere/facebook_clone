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
    
end
