ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

if CONFIG['admin_emails'].blank?
  CONFIG['admin_emails'] = %w(admin@example.com)
end

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  include FactoryGirl::Syntax::Methods

end

class ActionController::TestCase
  # Delegate auth private method
  %w(login_as logout current_user login?).each do |method|
    define_method method do |*args|
      @controller.send method, *args
    end
  end

  def upload_file(path)
    ActionDispatch::Http::UploadedFile.new(
      :tempfile => File.open(path),
      :filename => File.basename(path)
    )
  end
end

Topic.__elasticsearch__.create_index!
