class Admin::SessionsController < ApplicationController
  include Admin::SessionsHelper

  def new; end

  def create
    user = User.where("username = :val OR email = :val", val: params[:username_or_email]).limit(1).first
    if user && user.authenticate(params[:password])
      log_in user
      redirect_to root_url, notice: "Logged in"
    else
      flash.alert = "Bad username/password"
      redirect_to :back
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end