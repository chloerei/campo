# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification do
    user
    association :subject, factory: 'comment'
    name "comment"
  end
end
