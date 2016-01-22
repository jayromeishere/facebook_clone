FactoryGirl.define do
  factory :friend_request do
    # use association to designate 'belongs to' relationships 
    association :requester, factory: :user
    association :requested, factory: :user
   
    
    requester_id 1
    requested_id 2
    accepted false
    
    factory :accepted_friend_request do
      accepted true
    end
  end

end
