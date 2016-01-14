require 'rails_helper'
  #always include
  #also make sure to end file name with _spec

feature "User Login" do
  scenario "successful" do
    user = create(:user)
    
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: 'email_1@foobar.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    expect(current_path).to eql feed_path
  end
  
end
