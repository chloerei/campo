require 'test_helper'

class PasswordsControllerTest < ActionController::TestCase
  test "should get new page" do
    get :new
    assert_response :success, @response.body
  end

  test "should create password reset email" do
    create :user, email: 'user@example.com'

    assert_difference "ActionMailer::Base.deliveries.size" do
      post :create, email: 'user@example.com'
    end
    assert_redirected_to password_path

    reset_email = ActionMailer::Base.deliveries.last
    assert_equal 'user@example.com', reset_email.to[0]
  end

  test "should not create password reset email if user no exists" do
    assert_no_difference "ActionMailer::Base.deliveries.size" do
      post :create, email: 'user@example.com'
    end
    assert_template :new
  end
end
