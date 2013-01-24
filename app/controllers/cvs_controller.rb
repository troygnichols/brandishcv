class CvsController < ApplicationController

  def show
    @user = User.find_by_username!(params[:username])
    @cv = @user.current_cv
  end

  def edit
    @user = User.find_by_username(params[:username])
    @cv = @user.current_cv || @user.cvs.build
  end

  def update
    @user = User.find_by_username(params[:username])
    @cv = @user.cvs.build(markdown: params[:cv][:markdown])
    @user.update_cv!(@cv)
    redirect_to action: 'show'
  end

end