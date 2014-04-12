class Users::ConfirmationsController < ApplicationController
  before_action :login_required, :no_confirmed_required
  before_action :access_limiter, only: [:create]

  def new
    store_location params[:return_to]
  end

  def show
    if params[:token].present?
      @user = User.find_by_confirmation_token(params[:token])
      if @user && @user == current_user
        @user.confirm
        flash[:success] = I18n.t('users.confirmations.confirm_success')
        redirect_back_or_default root_url
      end
    end
  end

  def create
    UserMailer.confirmation(current_user.id).deliver
  end

  private

  def no_confirmed_required
    if current_user.confirmed?
      redirect_to root_url
    end
  end

  def access_limiter
    key = "verifies:limiter:#{request.remote_ip}"
    if $redis.get(key).to_i > 0
      render :limiter
    else
      $redis.incr(key)
      if $redis.ttl(key) == -1
        $redis.expire(key, 60)
      end
    end
  end
end
