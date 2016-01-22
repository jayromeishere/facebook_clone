class Notification < ActiveRecord::Base
  validates :recipient_id, :source_id, 
    presence: true,
    numericality: true
  validates :source_type,
    presence: true,
    inclusion: { in: ["Comment", "Like", "FriendRequest"] }
    
  belongs_to :source, 
    polymorphic: true
  belongs_to :recipient,
    class_name: "User"
    
  scope :from_friend_requests, -> { where(source_type: "FriendRequest") }
  
end