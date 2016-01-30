FactoryGirl.define do
  factory :like do
    liker_id 1
likeable_id 1
likeable_type "Comment"
recipient_id 2
self_like false
  end

end
