require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "confirmation" do
    user = create(:user)
    email = UserMailer.confirmation(user.id).deliver
    assert ActionMailer::Base.deliveries.any?
    assert_equal [user.email], email.to
  end
end
