require 'rails_helper'

feature "Notifications" do
  background do
    # use create to persist users in database
    @requester = create(:user, id: 1, name: "Jerome", email: "email_1@foobar.com", password: "password")
    @requested = create(:user, id: 2, name: "Bert", email: "email_2@foobar.com", password: "password")
    @other_user = create(:user, id: 3, name: "Cam", email: "email_3@foobar.com", password: "password")
  end
  
  scenario "current user receives one upon receiving a friend request" do
    expect{send_friend_request(@requester, @requested)}.to change(Notification, :count).by(1)
    sign_out
    sign_in(@requested)
    expect(page).to have_content "1 new notification"
  end
  
  scenario "friend request notification flagged as seen after user visits notifications page" do
    accept_friend_request_from_profile(@requester, @requested)
    sign_out
    sign_in(@requested)
    visit notifications_path
    expect(@requested.notifications.last.seen).to eql true
  end
  
  scenario "when a friend comments on user's post, user's notif page says friend commented on it" do
    accept_friend_request_from_profile(@requester, @requested) #requested still logged in after friend request is accepted
    post = @requester.posts.create(attributes_for(:post))
    comment_on(post)
    sign_out
    sign_in(@requester)
    visit notifications_path
    expect(page).to have_content "Bert commented on your post."
  end
  
  scenario "when user accepts friend request on profile page, notification goes away" do
    accept_friend_request_from_profile(@requester, @requested)
    visit notifications_path
    expect(page).to_not have_content "Jerome sent you a friend request."
  end
  
  scenario "when user comments on his own post, user DOESN'T receive notification" do
    accept_friend_request_from_profile(@requester, @requested) 
    post = @requested.posts.create(attributes_for(:post))
    comment_on(post)  
    visit notifications_path
    expect(page).to_not have_content "Bert commented on your post."
  end
  
  scenario "return to zero when user exits notification page" do
    accept_friend_request_from_profile(@requester, @requested)
    sign_out
    sign_in(@requested)
    visit notifications_path
    visit user_path(@requested)
    expect(page).to have_content "No new notifications."
  end
  
end
