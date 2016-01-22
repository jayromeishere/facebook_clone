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
    accept_friend_request(@requester, @requested)
    sign_out
    sign_in(@requested)
    visit notifications_path
    expect(@requested.notifications.last.seen).to eql true
  end
  
  scenario "return to zero when user exits notification page" do
    accept_friend_request(@requester, @requested)
    sign_out
    sign_in(@requested)
    visit notifications_path
    visit user_path(@requested)
    expect(page).to have_content "No new notifications."
  end
  
end
