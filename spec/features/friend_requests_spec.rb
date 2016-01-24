require 'rails_helper'

feature "Friend Requests" do
  background do
    # use create to persist users in database
    @requester = create(:user, id: 1, name: "Jerome", email: "email_1@foobar.com", password: "password")
    @requested = create(:user, id: 2, name: "Bert", email: "email_2@foobar.com", password: "password")
    @other_user = create(:user, id: 3, name: "Cam", email: "email_3@foobar.com", password: "password")
  end
  
  scenario "requested user receives a friend request from requester" do
    sign_in(@requester)
    visit user_path(@requested)
    expect{click_link 'Send Friend Request'}.to change(FriendRequest, :count).by(1)
    # change matcher requires a block 
    expect(page).to have_content "Friend Request Sent!"
  end
  
  scenario "upon receiving friend request, REQUESTED sees 'pending' on REQUESTER's profile" do
    send_friend_request(@requester, @requested)
    sign_out
    sign_in(@requested)
    visit user_path(@requester)
    expect(page).to have_content 'pending'   
  end

  scenario "upon sending friend request, REQUESTER sees 'pending' on REQUESTED's profile" do
    send_friend_request(@requester, @requested)
    visit user_path(@requested)
    expect(page).to have_content 'pending'
  end  
  
  scenario "requested user accepts requester's friend request" do
    send_friend_request(@requester, @requested)
    sign_out
    sign_in(@requested)
    visit user_path(@requested)
    click_link 'Accept?'
    expect(page).to have_content "Friend Request Accepted!"
    expect(page).to have_content '1 friend'
    visit user_path(@requester)
    expect(page).to have_content '1 friend'
  end
  
  scenario "when user 1 sends user 2 a Friend Request, user 3's page doesn't say 'FR pending' " do
    send_friend_request(@requester, @requested)
    sign_out
    sign_in(@other_user)
    visit user_path(@other_user)
    expect(page).to_not have_content "Friend Request pending"
  end
  
  scenario "friend request successfully deleted" do
    accept_friend_request_from_profile(@requester, @requested)
    visit user_path(@requester)
    expect{click_link 'Unfriend?'}.to change(FriendRequest, :count).by(-1)
  end
  
end
