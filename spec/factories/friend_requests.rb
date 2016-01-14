FactoryGirl.define do
  factory :friend_request do
    requester_id 1
    requested_id 2
    accepted false
  end

end
