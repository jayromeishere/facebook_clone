class FriendRequest < ActiveRecord::Base
  validates :requester_id, :requested_id, presence: true, numericality: true
  validates :accepted, presence: true
  
  belongs_to :requester, class_name: "User"
  belongs_to :requested, class_name: "User"
end
