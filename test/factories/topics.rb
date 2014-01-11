# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :topic do
    title "MyString"
    user
    before(:create) { |topic| topic.build_main_post user: topic.user, content: 'Content' }
  end
end
