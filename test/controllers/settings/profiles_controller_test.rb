require 'test_helper'

class Settings::ProfilesControllerTest < ActionController::TestCase
  def setup
    login_as create(:user)
  end

  test "should get profile page" do
    get :show
    assert_response :success, @response.body
  end

  test "should update profile" do
    patch :update, user: { name: 'change' }
    assert_equal 'change', current_user.reload.name
  end
end
