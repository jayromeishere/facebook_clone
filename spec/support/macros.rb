module Macros
    
  # friend requests 
    
  def send_friend_request(requester, requested)
    sign_in(requester)
    visit user_path(requested)
    click_link 'Send Friend Request'
  end
  
  def accept_friend_request_from_profile(requester, requested)
    send_friend_request(requester, requested)
    sign_out
    sign_in(requested)
    visit user_path(requested)
    click_link 'Accept?'
  end
  
  # logging in 
  
  def sign_in(user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end
  
  def sign_out
    visit root_path
    click_link 'Sign Out'
  end
  
  # comments 
  
  def comment_on(post)
    # assumes current_user is commenting 
    visit user_post_path(post.poster_id, post.id)
    click_link "Comment"
    fill_in 'comment[text]', with: "sample text" 
    click_button "Submit"
  end
  
  
end