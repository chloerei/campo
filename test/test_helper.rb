ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  include FactoryGirl::Syntax::Methods

  # Delegate auth private method
  %w(login_as logout current_user logined?).each do |method|
    define_method method do |*args|
      @controller.send method, *args
    end
  end

  def assert_require_logined(user = create(:user))
    logout
    yield
    assert_redirected_to login_url
    login_as user
    yield
  end
end
