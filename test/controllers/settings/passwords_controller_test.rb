require 'test_helper'

class Settings::PasswordsControllerTest < ActionController::TestCase
  def setup
    login_as create(:user, password: '123456')
  end

  test "should get settings password page" do
    get :show
    assert_response :success, @response.body
  end

  test "should update passowrd" do
    patch :update, current_password: '123456', user: { password: '654321', password_confirmation: '654321' }
    assert current_user.reload.authenticate '654321'
  end

  test "should not update password without current_password" do
    patch :update, user: { password: '654321', password_confirmation: '654321' }
    assert !current_user.reload.authenticate('654321')

    patch :update, current_password: 'wrongpassword', user: { password: '654321', password_confirmation: '654321' }
    assert !current_user.reload.authenticate('654321')
  end
end
