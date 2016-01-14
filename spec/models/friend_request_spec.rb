require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  
  it "is valid" do
    expect(build(:friend_request)).to be_valid
  end
  
end
