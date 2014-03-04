FactoryGirl.define do
  factory :user do
    name 'name'
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:username) { |n| "username#{n}" }
    password '12345678'
    bio 'bio'
  end

  factory :admin, parent: 'user' do
    email CONFIG['admin_emails'].first
  end
end
