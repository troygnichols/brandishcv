require 'test_helper'

class Admin::PasswordResetsControllerTest < ActionController::TestCase
  setup do
    @user = users(:bruce_lee)
  end

  #################
  # Create
  #################

  test "password reset request for non-existent user fakes sending message" do
    bad_email = 'bad@email.com'
    refute User.find_by(email: bad_email)
    post :create, email: bad_email
    assert_response :success
    assert_template :show
  end

  test "password reset request for real, active user sends an email" do
    post :create, email: @user.email
    assert_response :success
    assert_template :show
  end

  #################
  # Edit
  #################

  test "edit with invalid token gives error" do
    assert_raise ActiveRecord::RecordNotFound do
      get :edit, id: 'not-a-real-token'
    end
  end

  test "edit loads user when given valid token" do
    @user.send_password_reset
    get :edit, id: @user.password_reset_token
    assert_response :success
    assert_template :edit
    assert_equal @user, assigns(:user)
  end

  #################
  # Update
  #################

  test "update fails without valid password reset token" do
    assert_raise ActiveRecord::RecordNotFound do
      post :update, id: 'not-a-real-token', password: 'newpassword', password_confirmation: 'newpassword'
      refute @controller.logged_in?
    end
  end

  test "update fails when token is expired" do
    @user.send_password_reset
    @user.password_reset_sent_at = DateTime.now - 2.days
    @user.save!
    post :update, id: @user.password_reset_token, password: 'newpassword', password_confirmation: 'newpassword'
    assert_redirected_to new_admin_password_reset_url
    assert_equal "Time limit expired.  Try again?", flash[:alert]
    refute @controller.logged_in?
  end

  test "update fails with illegal password not allowed" do
    @user.send_password_reset
    post :update, id: @user.password_reset_token, password: '2short', password_confirmation: '2short'
    assert_response :success
    assert_template :edit
    refute @controller.logged_in?
    assert_error_on assigns(:user), "Password is too short (minimum is 10 characters)"
  end

  test "update with password confirmation mismatch fails" do
    @user.send_password_reset
    post :update, id: @user.password_reset_token, password: 'password_one', password_confirmation: 'password_two'
    assert_response :success
    assert_template :edit
    refute @controller.logged_in?
    assert_error_on assigns(:user), "Password confirmation doesn't match Password"
  end

  test "update with valid password succeeds" do
    @user.send_password_reset
    post :update, id: @user.password_reset_token, password: 'newpassword', password_confirmation: 'newpassword'
    assert_redirected_to root_url
    assert_equal "Password has been reset.  Welcome back.", flash[:notice]
    assert_equal @user, @controller.current_user
  end
end
