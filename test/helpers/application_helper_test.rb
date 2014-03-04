require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "return_to should return right path" do
    assert_equal nil, return_to_path('/')
    assert_equal '/?page=2', return_to_path('/?page=2')
    assert_equal nil, return_to_path('/login')
    assert_equal nil, return_to_path('/signup')
    assert_equal '/topics', return_to_path('/topics')
  end
end
