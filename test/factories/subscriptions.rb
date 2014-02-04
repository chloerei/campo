FactoryGirl.define do
  factory :subscription do
    user
    association :subscribable, factory: 'topic'
  end
end
