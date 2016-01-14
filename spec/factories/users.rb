FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "email_#{n}@foobar.com"
    end
  end
end
