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

  test "should get new page" do
    get :new
    assert_response :success, @response.body
  end

  test "should create category" do
    assert_difference "Category.count" do
      post :create, category: attributes_for(:category)
    end
  end

  test "should update category" do
    category = create(:category)
    patch :update, id: category, category: { name: 'change' }
    assert_equal 'change', category.reload.name
  end

  test "should destroy category" do
    category = create(:category)
    assert_difference "Category.count", -1 do
      delete :destroy, id: category
    end
  end
end
