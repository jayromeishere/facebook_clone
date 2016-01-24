module FriendRequestMacros
  
  def send_friend_request(requester, requested)
    sign_in(requester)
    visit user_path(requested)
    click_link 'Send Friend Request'
  end
  
  def accept_friend_request(requester, requested)
    send_friend_request(requester, requested)
    sign_out
    sign_in(@requested)
    visit user_path(@requested)
    click_link 'Accept?'
  end
  
end