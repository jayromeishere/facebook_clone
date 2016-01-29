require 'rails_helper'

feature "Likes" do
  background do
    # use create to persist users in database
    @liker = create(:user, id: 1, name: "Jerome", email: "email_1@foobar.com", password: "password")
    @creator = create(:user, id: 2, name: "Bert", email: "email_2@foobar.com", password: "password")
    @other_user = create(:user, id: 3, name: "Cam", email: "email_3@foobar.com", password: "password")
    @post = create(:post, poster_id: @creator.id, text: "mah")
  end
  
  #contexts: liker == creator, liker != creator 
  
  # scenario "Like model increases by 1 when user likes a post"
    # context "user likes someone else's post"
    # context "user likes his own post"
  # scenario "Like model increases by 1 when user likes a comment"
    # context "user likes someone else's comment"
    # context "user likes his own comment"
  # scenario "Like model decrements by 1 when a user unlikes a post"
    # context "user unlikes someone else's post"
    # context "user unlikes his own post"
  # scenario "Like model decrements by 1 when a user unlikes a comment"
    # context "user unlikes someone else's comment"
    # context "user unlikes his own comment"
    
  scenario "Post creator receives a notification when a friend likes the post" do
    @post.likes.create(liker_id: @liker.id, likeable_type: "Post")
    sign_in(@creator)
    visit notifications_path
    expect(page).to have_content "Jerome liked your post."
  end
  
  scenario "Post creator DOESN'T receive notif IN NAV BAR if he likes his own post" do
    post_by_liker = create(:post, poster_id: @liker.id)
    post_by_liker.likes.create(liker_id: @liker.id, likeable_type: "Post")
    sign_in(@liker)
    visit notifications_path
    expect(page).to_not have_content "Jerome liked your post." 
  end
  
  scenario "Comment creator receives a notification when a friend likes the comment" do
    comment = @post.comments.create(commenter_id: @other_user.id, text: "asuhhhh")
    comment.likes.create(liker_id: @liker.id, likeable_type: "Comment")
    sign_in(@other_user)
    visit notifications_path
    expect(page).to have_content "Jerome liked your comment."
  end
  
  scenario "Comment creator DOESN'T receive notif if he likes his own comment" do
    comment = @post.comments.create(commenter_id: @liker.id, text: "asuhhhh")
    comment.likes.create(liker_id: @liker.id, likeable_type: "Comment")
    sign_in(@liker)
    visit notifications_path
    expect(page).to_not have_content "Jerome liked your comment."
  end
  
  scenario "Like destroyed after unliking a post" do
    
  end
  scenario "Like destroyed after unliking a comment"
  


  
end