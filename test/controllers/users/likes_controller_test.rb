require 'test_helper'

class Users::LikesControllerTest < ActionController::TestCase
  def setup
    @user = create(:user)
  end

  test "should get index" do
    create(:like, user: @user)

    get :index, username: @user.username
    assert_response :success, @response.body
  end

  test "should destroy like" do
    like = create(:like, user: @user)
    login_as @user

    assert_difference "@user.likes.count", -1 do
      xhr :delete, :destroy, username: @user.username, id: like
    end
  end
end
