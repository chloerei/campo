require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should create user" do
    assert_not_nil create(:user)
  end
end
