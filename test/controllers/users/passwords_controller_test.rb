require 'test_helper'

class Users::PasswordsControllerTest < ActionController::TestCase
  test "should get new page" do
    get :new
    assert_response :success, @response.body
  end

  test "should create password reset email" do
    create :user, email: 'user@example.com'

    assert_difference "ActionMailer::Base.deliveries.size" do
      post :create, email: 'user@example.com'
    end
    assert_redirected_to users_password_path

    reset_email = ActionMailer::Base.deliveries.last
    assert_equal 'user@example.com', reset_email.to[0]
  end

  test "email case-insensitive" do
    user = create :user, email: 'user@example.com'
    post :create, email: 'User@example.com'
    assert_equal user, assigns(:user)
  end

  test "should not create password reset email if user no exists" do
    assert_no_difference "ActionMailer::Base.deliveries.size" do
      post :create, email: 'user@example.com'
    end
    assert_template :new
  end

  test "should not get edit page if token invalid" do
    user = create(:user)
    get :edit, email: user.email
    assert_redirected_to new_users_password_path
  end

  test "should not get edit page if token expired" do
    user = create(:user)
    get :edit, token: User.verifier_for('password-reset').generate([user.id, 2.hours.ago])
    assert_redirected_to new_users_password_path
  end

  test "should get edit page" do
    user = create(:user)
    get :edit, email: user.email, token: user.password_reset_token
    assert_response :success, @response.body
  end

  test "should not update password if token invalid" do
    user = create(:user)
    post :update, email: user.email, user: { password: 'change', password_confirmation: 'change' }
    assert !user.reload.authenticate('change')
  end

  test "should update password" do
    user = create(:user)
    post :update, email: user.email, token: user.password_reset_token, user: { password: 'change', password_confirmation: 'change' }
    assert user.reload.authenticate('change')
  end
end
