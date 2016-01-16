require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  
  it "is valid" do
    expect(build(:friend_request)).to be_valid
  end
  
  it "is unique up to the requested id" do
    create(:friend_request, requester_id: 1, requested_id: 2)
    expect(build(:friend_request, requester_id: 1, requested_id: 2)).to be_invalid
  end
  
end
