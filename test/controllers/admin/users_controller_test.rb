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

  test "should destroy user" do
    user = create(:user)
    assert_difference "User.count", -1 do
      delete :destroy, id: user
    end
    assert_redirected_to admin_users_path
  end
end
