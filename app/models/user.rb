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
  has_many :notifications, 
    foreign_key: "recipient_id",
    dependent: :destroy
  has_many :posts,
    foreign_key: "poster_id",
    dependent: :destroy
  has_many :written_comments, 
    class_name: "Comment",
    foreign_key: "commenter_id",
    dependent: :destroy
    
  has_many :friends_from_active_requests, -> (user) { where("friend_requests.accepted = ?", true) },
    through: :active_friend_requests,
    source: :requested,
    class_name: "User",
    dependent: :destroy
  has_many :friends_from_passive_requests, -> (user) { where("friend_requests.accepted = ?", true) },
    through: :passive_friend_requests, 
    source: :requester,
    class_name: "User",
    dependent: :destroy

  # methods with respect to current_user 
  
  def has_active_friend_request_pending_with?(user)
    active_friend_requests.where("requested_id = ?", user.id).pending == User.none ? false : true
    # User.none = empty ActiveRecord association
  end
  
  def has_passive_friend_request_pending_with?(current_user)
    passive_friend_requests.where("requester_id = ?", current_user.id).pending == User.none ? false : true 
  end
  
  def has_passive_friend_requests_pending?
    passive_friend_requests.pending.count > 0 ? true : false 
  end
 

   
end

