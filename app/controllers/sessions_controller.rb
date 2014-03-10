class SessionsController < ApplicationController
  before_filter :access_limiter, only: [:new, :create]

  def new
    store_location params[:return_to]
  end

  def create
    login = params[:login].downcase
    @user = if login.include?('@')
              User.where('lower(email) = ?', login).first
            else
              User.where('lower(username) = ?', login).first
            end

    if @user && @user.authenticate(params[:password])
      login_as @user
      remember_me
      redirect_back_or_default root_url
    else
      flash[:warning] = I18n.t('sessions.flashes.incorrect_user_name_or_password')
      redirect_to login_url
    end
  end

  def destroy
    logout
    redirect_to root_url
  end

  private

  def access_limiter
    key = "sessions:limiter:#{request.remote_ip}"
    if $redis.get(key).to_i > 4
      render :access_limiter
    elsif action_name != 'new' # get login page not incr limiter
      $redis.incr(key)
      if $redis.ttl(key) == -1
        $redis.expire(key, 60)
      end
    end
  end
end
