require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should create user" do
    assert_not_nil create(:user)
  end

  test "should have remember token" do
    user = create(:user)
    assert_not_nil user.remember_token
    assert_equal user, User.find_by_remember_token(user.remember_token)
    assert_equal nil, User.find_by_remember_token('invalidtoken')
  end

  test "should genrate password_reset_token" do
    user = create(:user)
    assert_not_nil user.password_reset_token
  end

  test "should find_by_password_reset_token" do
    user = create(:user)
    token = user.password_reset_token
    assert_equal user, User.find_by_password_reset_token(token)
  end

  test "shuold generate confirmation token" do
    user = create(:user)
    assert_not_nil user.confirmation_token
  end

  test "should find_by_confirmation_token" do
    user = create(:user)
    token = user.confirmation_token
    assert_equal user, User.find_by_confirmation_token(token)
  end

  test "should include email info in confirmation_token" do
    user = create(:user)
    token = user.confirmation_token
    user.update_attribute :email, 'change@example.org'
    assert_nil User.find_by_confirmation_token(token)
  end
end
