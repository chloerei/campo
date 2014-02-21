class Settings::ApplicationController < ApplicationController
  before_filter :login_required, :set_user

  private

  def set_user
    @user = current_user
  end
end
