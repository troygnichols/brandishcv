class Admin::PasswordResetsController < ApplicationController

  def new; end

  def create
    @user = User.find_by(email: params[:email])
    @user.send_password_reset if @user
    render :show
  end

  def edit
    @user = User.find_by!(password_reset_token: params[:id])
  end

  def update
    @user = User.find_by!(password_reset_token: params[:id])
    begin
      if @user.reset_password(params[:password], params[:password_confirmation])
        log_in @user
        redirect_to root_url, notice: "Password has been reset.  Welcome back."
      else
        render :edit
      end
    rescue PasswordResetExpired
      redirect_to new_admin_password_reset_url, alert: "Time limit expired.  Try again?"
    end
  end
end
