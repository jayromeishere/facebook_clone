class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  has_many :active_friend_requests, 
    class_name: "FriendRequest",
    foreign_key: "requester_id",
    dependent: :destroy
  has_many :passive_friend_requests, 
    class_name: "FriendRequest",
    foreign_key: "requested_id",
    dependent: :destroy
  has_many :friends, 
    through: :friend_requests, 
    source: :requested

  
  def has_active_friend_request_pending_with(requested_id)
    active_friend_requests.where("requested_id = ?", requested_id).pending != nil
  end
  
  def has_passive_friend_requests_pending
    passive_friend_requests.pending.count > 0
  end
  
end

