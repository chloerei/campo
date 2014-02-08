FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "name#{n}" }
    sequence(:slug) { |n| "slug#{n}" }
  end
end
