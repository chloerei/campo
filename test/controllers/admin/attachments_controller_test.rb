require 'test_helper'

class Admin::AttachmentsControllerTest < ActionController::TestCase
  def setup
    login_as create(:admin)
  end

  test "should get index" do
    create :attachment

    get :index
    assert_response :success, @response.body
  end

  test "should delete attachment" do
    attachment = create(:attachment)

    assert_difference "Attachment.count", -1 do
      xhr :delete, :destroy, id: attachment
    end
  end
end
