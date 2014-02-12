class Users::ApplicationController < ApplicationController
  before_filter :find_user

  private

  def find_user
    @user = User.find_by! username_lower: params[:username].downcase
  end
end
