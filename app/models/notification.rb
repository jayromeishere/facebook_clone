class Notification < ActiveRecord::Base
  validates :recipient_id, :source_id, 
    presence: true,
    numericality: true
  validates :source_type,
    presence: true,
    inclusion: ["comment", "like", "friend request"] 
    
  belongs_to :source, 
    polymorphic: true 
  belongs_to :recipient,
    class_name: "User"
  
end
