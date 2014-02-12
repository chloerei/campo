require 'test_helper'

class Users::CommentsControllerTest < ActionController::TestCase
  def setup
    @user = create(:user)
  end

  test "should get index" do
    get :index, username: @user.username
    assert_response :success, @response.body
  end
end
