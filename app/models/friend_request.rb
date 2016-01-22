class FriendRequest < ActiveRecord::Base
  validates :requester_id, :requested_id, 
    presence: true, 
    numericality: true
  # http://stackoverflow.com/questions/4870961/rails-validate-uniqueness-of-multiple-columns
  validates :requester_id,
    uniqueness: { scope: :requested_id }
  validates :accepted,
    inclusion: [true, false]
  
  belongs_to :requester, 
    class_name: "User"
  belongs_to :requested, 
    class_name: "User"
  has_many :notifications,
    as: :source, 
    dependent: :destroy
    
  scope :pending, -> { where(accepted: false) }
  scope :accepted, -> { where(accepted: true) }

end
