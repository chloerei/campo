class SessionsController < ApplicationController
  def new
    store_location params[:return_to] if params[:return_to].present?
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
      redirect_back_or_default root_url
    else
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url
  end
end
