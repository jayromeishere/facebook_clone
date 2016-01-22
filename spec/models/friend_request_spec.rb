require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  
  it "is valid" do
    expect(build(:friend_request)).to be_valid
  end
  
  it "is unique up to the requested id" do
    create(:friend_request)
    expect(build(:friend_request)).to be_invalid
  end
  
end
