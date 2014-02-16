require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase
  def setup
    login_as create(:admin)
  end

  test "should get index" do
    get :index
    assert_response :success, @response.body
  end

  test "should get show page" do
    user = create(:user)
    get :show, id: user
    assert_response :success, @response.body
  end

  test "shuold update user" do
    user = create(:user)
    patch :update, id: user, user: { name: 'change' }
    assert_equal 'change', user.reload.name
  end

  test "should destroy user" do
    user = create(:user)
    assert_difference "User.count", -1 do
      delete :destroy, id: user
    end
  end

  test "should lock user" do
    user = create(:user)

    patch :lock, id: user
    assert user.reload.locked?
  end

  test "should unlock user" do
    user = create(:user)
    user.lock

    delete :unlock, id: user
    assert !user.reload.locked?
  end
end
