require 'test_helper'

class Admin::CategoriesControllerTest < ActionController::TestCase
  def setup
    login_as create(:admin)
  end

  test "should get index" do
    create(:category)
    get :index
    assert_response :success, @response.body
  end

  test "should get show" do
    get :show, id: create(:category)
    assert_response :success, @response.body
  end
end
