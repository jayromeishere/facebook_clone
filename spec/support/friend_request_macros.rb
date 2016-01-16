module FriendRequestMacros
  
  def send_friend_request(requester, requested)
    sign_in(requester)
    visit user_path(requested)
    click_link 'Send Friend Request'
  end
  
end