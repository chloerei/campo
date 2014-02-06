# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :topic do
    user
    title "MyString"
    body "MyString"
  end
end
