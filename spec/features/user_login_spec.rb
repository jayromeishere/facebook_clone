require 'rails_helper'
  #always include
  #also make sure to end file name with _spec
  #used with Capybara gem 

feature "User Login" do
  background do
    user = create(:user, email: "email_1@foobar.com", password: "password")
  end 
  
  scenario "successful" do    
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: 'email_1@foobar.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    expect(current_path).to eql feed_path
  end
  
  scenario "unsuccessful" do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: 'email_1@foobar.com'
    fill_in 'Password', with: 'bad_password'
    click_button 'Log in'
    expect(current_path).to eql new_user_session_path
  end
end
