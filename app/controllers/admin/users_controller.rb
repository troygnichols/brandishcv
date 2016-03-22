class Admin::UsersController < ApplicationController
  filter_resource_access

  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  def new
    respond_to do |format|
      format.html
      format.json{ render json: @user }
    end
  end

  def create
    respond_to do |format|
      if @user.save
        format.html { redirect_to show_cv_path(@user.username), notice: 'User created successfully' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  def update
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to show_cv_path(@user.username), notice: 'User updated successfully' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url }
      format.json { head :no_content }
    end
  end

  def user_params
    params.require(:user).permit(:username, :email, :admin, :password, :password_confirmation)
  end
end
