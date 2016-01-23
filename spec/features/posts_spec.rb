require 'rails_helper'

feature "Posts" do
  background do
    @user = create(:user)
    @post = build(:post)
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
end
