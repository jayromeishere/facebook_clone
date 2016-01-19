module UsersHelper
  
  def friends_count(user)
    user.active_friend_requests.accepted.count + user.passive_friend_requests.accepted.count
  end
  
  def are_friends?(current_user, user)
    current_user.active_friend_requests.where("requested_id = ?", user.id).accepted != User.none || 
    current_user.passive_friend_requests.where("requester_id = ?", user.id).accepted != User.none ? true : false 
  end
  
  def friend_request_pending_between?(current_user, user)
    current_user.active_friend_requests.where("requested_id = ?", user.id).pending != User.none || 
    current_user.passive_friend_requests.where("requester_id = ?", user.id).pending != User.none ? true : false 
  end
  
  def notification_count_for(user)
    user.passive_friend_requests.count
    # + when someone comments on or likes user's content
  end
  
  def display_notification_count_for(user)
    notification_count_for(user) == 0 ? "No new notifications." : "#{notification_count_for(user)} new notifications."
  end
 
end
