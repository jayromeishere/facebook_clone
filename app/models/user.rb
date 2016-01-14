class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  has_many :friend_requests, 
    dependent: :destroy
  has_many :friends, 
    through: :friend_requests, 
    source: :requested

  
  def self.accept_friend_request(id)
    self.friend_requests.find_by(id).accepted = true
  end
  
end

