FactoryGirl.define do
  factory :like do
    user
    association :likeable, factory: 'comment'
  end
end
