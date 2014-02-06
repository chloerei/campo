FactoryGirl.define do
  factory :comment do
    user
    body "Content"
    association :commentable, factory: 'topic'
  end
end
