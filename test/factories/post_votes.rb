FactoryGirl.define do
  factory :post_vote do
    user
    post
    up true
  end
end
