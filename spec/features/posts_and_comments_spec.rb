require 'rails_helper'

feature "Posts and Comments" do
  background do
    @user = create(:user)
    @commenter = create(:user)
    @post = @user.posts.create(attributes_for(:post))
    @user.active_friend_requests.create(requested_id: @commenter.id, accepted: true)
  end
  
  scenario "Post model increases by 1 after user submits a post from their feed" do
    sign_in(@user)
    fill_in 'post[text]', with: "sample text"
    expect{click_button "Post Now"}.to change(Post, :count).by(1)
  end
  
  scenario "Post model increases by 1 after user submits a post from their profile" do
    sign_in(@user)
    visit user_path(@user)
    fill_in 'post[text]', with: "sample text"
    expect{click_button "Post Now"}.to change(Post, :count).by(1)
  end
  
  scenario "Comment model increases by 1 after commenter comments on a user's post" do
    sign_in(@commenter)
    expect{comment_on(@post)}.to change(Comment, :count).by(1)
  end
  
  scenario "Post poster receives a notification when commenter comments on their post" do
    sign_in(@commenter)
    expect{comment_on(@post)}.to change{@user.notifications.count}.by(1)
    # note hash after change matcher 
  end
  
  
end
