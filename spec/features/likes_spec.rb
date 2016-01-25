require 'rails_helper'

feature "Likes" do
  background do
    # use create to persist users in database
    @liker = create(:user, id: 1, name: "Jerome", email: "email_1@foobar.com", password: "password")
    @creator = create(:user, id: 2, name: "Bert", email: "email_2@foobar.com", password: "password")
    @other_user = create(:user, id: 3, name: "Cam", email: "email_3@foobar.com", password: "password")
  end
  
  #contexts: liker == creator, liker != creator 
  
  shared_examples_for "changes in Like model" do
    scenario "Like model increases by 1 when user likes a post" do
      sign_in(@liker)
      post = @creator.posts.create(text: "woooo")
      visit user_post_path(@creator.id, post.id)
      expect{click_link "Like"}.to change(Like, :count).by(1)
    end
  end
  
  describe "when liker is not the creator" do
    it_behaves_like "changes in Like model"
  end
  
  describe "when liker is the creator" do
    before(:each) do
      @liker = @creator
    end
    
    it_behaves_like "changes in Like model"
  end
  
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
  # scenario "Post creator receives a notification when a friend likes the post"
  # scenario "Post creator DOESN'T receive notif if he likes his own post"
  # scenario "Comment creator receives a notification when a friend likes the comment"
  # scenario "Comment creator DOESN'T receive notif if he likes his own comment"

  
end