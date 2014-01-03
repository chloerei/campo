require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should create user" do
    assert_not_nil create(:user)
  end

  test "should save lower username" do
    assert_equal "lower", create(:user, username: 'LOWER').username_lower
  end
end
