class User < ActiveRecord::Base
  validates :name,
    presence: true, 
    length: { minimum: 3 }
  has_many :friend_requests, 
    dependent: :destroy
  has_many :friendships, 
    through: :friend_requests, 
    source: :requested

  
  def self.accept_request(id)
    self.friend_requests.find_by(id).accepted = true
  end
  
end
