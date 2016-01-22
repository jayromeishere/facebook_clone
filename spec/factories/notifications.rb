FactoryGirl.define do
  factory :notification do
    association :user
    
    recipient_id 1
    source_id "MyString"
    integer "MyString"
    source_type "MyString"
  end

end
