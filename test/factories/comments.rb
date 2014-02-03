FactoryGirl.define do
  factory :comment do
    user
    content "Content"
    association :commentable, factory: 'topic'
  end
end
