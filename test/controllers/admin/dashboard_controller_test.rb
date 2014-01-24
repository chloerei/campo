require 'test_helper'

class Admin::DashboardControllerTest < ActionController::TestCase
  test "should raise if no admin" do
    login_as create(:user)
    assert_raise(ApplicationController::AccessDenied) do
      get :show
    end
  end

  test "should get show page" do
    login_as create(:admin)
    get :show
    assert_response :success, @response.body
  end
end
