require 'rails_helper'

feature "Friend Requests" do
  background do
    # use create to persist users in database
    @requester = create(:user, id: 1, email: "email_1@foobar.com", password: "password")
    @requested = create(:user, id: 2, email: "email_2@foobar.com", password: "password")
  end
  
  scenario "requested user receives a friend request from requester" do
    sign_in(@requester)
    visit user_path(@requested)
    expect{click_link 'Send Friend Request'}.to change(FriendRequest, :count).by(1)
    # change matcher requires a block 
    expect(page).to have_content "Friend Request Sent!"
  end
  
  scenario "requested user accepts requester's friend request" do
    send_friend_request(@requester, @requested)
    sign_out
    sign_in(@requested)
    visit user_path(@requested)
    click_link 'Accept?'
    expect(page).to have_content "Friend Request Accepted!"
  end
  
end
