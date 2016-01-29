class Notification < ActiveRecord::Base
  validates :recipient_id, :source_id, :sender_id,
    presence: true,
    numericality: true
  validates :source_type,
    presence: true,
    inclusion: { in: ["Comment", "Like", "FriendRequest"] }
    
  belongs_to :source, 
    polymorphic: true
  belongs_to :recipient,
    class_name: "User"
  belongs_to :sender,
    class_name: "User"
  belongs_to :like
    
  scope :from_friend_requests, -> { where(source_type: "FriendRequest") }
  scope :unseen, -> { where(seen: false) }
  scope :seen, -> { where(seen: true) }
  scope :excluding_self_likes, -> { joins("FULL OUTER JOIN likes ON likes.id = notifications.source_id").
                                    where("likes.self_like = ?", false) }
  
  
end