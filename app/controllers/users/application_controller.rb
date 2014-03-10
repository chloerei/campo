class Users::ApplicationController < ApplicationController
  before_filter :find_user

  private

  def find_user
    @user = User.where('lower(username) = ?', params[:username].downcase).first!
  end
end
