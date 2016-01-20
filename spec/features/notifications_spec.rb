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
  
end
