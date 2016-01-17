module UsersHelper
  
  def friends_count(user)
    user.active_friend_requests.accepted.count + user.passive_friend_requests.accepted.count
  end
  
end
