class SessionsController < ApplicationController
  def new
  end

  def create
    login = params[:login].downcase
    @user = if login.include?('@')
              User.find_by email_lower: login
            else
              User.find_by username_lower: login
            end

    if @user && @user.authenticate(params[:password])
      login_as @user
      remember_me
      redirect_to root_url
    else
      render :new
    end
  end
end
