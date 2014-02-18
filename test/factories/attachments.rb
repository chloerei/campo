FactoryGirl.define do
  factory :attachment do
    user
    file File.open('app/assets/images/rails.png')
  end
end
