FactoryGirl.define do
  factory :post_vote do
    user
    post
    value 'up'
  end
end
