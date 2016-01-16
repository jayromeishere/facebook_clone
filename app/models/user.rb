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
  has_many :friend_requests,
    foreign_key: "requester_id"

  
  def has_active_friend_request_pending_with?(user)
    active_friend_requests.where("requested_id = ?", user.id).pending == User.none ? false : true
    # User.none = empty ActiveRecord association
  end
  
  def has_passive_friend_requests_pending?
    passive_friend_requests.pending.count > 0 ? true : false 
  end
  
  def is_friends_with?(requested)
    active_friend_requests.where("requested_id = ?", requested.id).accepted != User.none ? true : false 
  end
  
end

