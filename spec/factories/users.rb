FactoryGirl.define do
  factory :user do
    password "password"
    password_confirmation "password"
    sequence :email do |n|
      "email_#{n}@foobar.com"
    end
  end
end
