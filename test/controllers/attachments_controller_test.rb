require 'test_helper'

class AttachmentsControllerTest < ActionController::TestCase
  def setup
    login_as create(:user)
  end

  test "should create attachment" do
    assert_difference "current_user.attachments.count" do
      post :create, attachment: { file: upload_file('app/assets/images/rails.png') }
    end
  end
end
