class FriendRequestObserver < ActiveRecord::Observer
  def after_create(friend_request)
    friend_request.notifications.create(
      sender_id: friend_request.requester_id,
      recipient_id: friend_request.requested_id
     )
  end
end
