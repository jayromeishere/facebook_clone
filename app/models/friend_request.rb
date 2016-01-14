class FriendRequest < ActiveRecord::Base
  validates :requester_id, :requested_id, 
    presence: true, 
    numericality: true
  validates :accepted,
    inclusion: [true, false]
  
  belongs_to :requester, 
    class_name: "User"
  belongs_to :requested, 
    class_name: "User"
    
  scope :pending, -> { where(accepted: false) }
  scope :accepted, -> { where(accepted: true) }
  
end
