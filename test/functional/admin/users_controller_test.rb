require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase

  setup do
    @user = users(:bruce_lee)
    @admin = users(:admin)
  end

  ###########################
  # Index
  ###########################

  test "should get index of all users when logged in as admin" do
    @controller.log_in @admin
    get :index
    assert_response :success
  end

  test "should not get index when not logged in" do
    refute @controller.logged_in?
    get :index
    assert_auth_failed
  end

  test "should not get index when logged in as non-admin user" do
    @controller.log_in @user
    get :index
    assert_auth_failed
  end

  ###########################
  # New
  ###########################
  test "should get new when logged in as admin" do
    @controller.log_in @admin
    get :new
    assert_response :success
    assert assigns(:user)
  end

  test "should not get new when not logged in" do
    refute @controller.logged_in?
    get :new
    assert_auth_failed
  end

  test "should not get new when logged in as non-admin user" do
    @controller.log_in @user
    get :new
    assert_auth_failed
  end

  ###########################
  # Create
  ###########################
  test "should create user when logged in as admin" do
    @controller.log_in @admin
    assert_difference 'User.count', +1 do
      post :create, user: {
          email: 'captain.beefheart@magicband.org',
          username: 'donvanvliet',
          password: 'bongofury42',
          password_confirmation: 'bongofury42'
      }
      created = assigns(:user)
      assert_valid created
      assert_redirected_to show_cv_path(created.username)
    end
  end

  test "should not create user when not logged in" do
    refute @controller.logged_in?
    assert_no_difference 'User.count' do
      post :create, user: {
          email: 'captain.beefheart@magicband.org',
          username: 'donvanvliet',
          password: 'bongofury42',
          password_confirmation: 'bongofury42'
      }
      assert_auth_failed
    end
  end

  test "should not create user when logged in as non-admin user" do
    @controller.log_in @user
    assert_no_difference 'User.count' do
      post :create, user: {
          email: 'captain.beefheart@magicband.org',
          username: 'donvanvliet',
          password: 'bongofury42',
          password_confirmation: 'bongofury42'
      }
      assert_auth_failed
    end
  end

  ###########################
  # Show
  ###########################
  test "should show existing user when logged in as admin" do
    @controller.log_in @admin
    get :show, id: @user
    assert_response :success
    assert_equal @user, assigns(:user)
  end

  test "should not show existing user when not logged in" do
    refute @controller.logged_in?
    get :show, id: @user
    assert_auth_failed
  end

  test "should not show existing user when logged in as non-admin user" do
    @controller.log_in @user
    get :show, id: @user
    assert_auth_failed
  end

  ###########################
  # Edit
  ###########################
  test "should get edit when logged in as admin" do
    @controller.log_in @admin
    get :edit, id: @user
    assert_response :success
    assert_equal @user, assigns(:user)
  end

  test "should not edit when not logged in" do
    refute @controller.logged_in?
    get :edit, id: @user
    assert_auth_failed
  end

  test "should edit other user when logged in as non-admin user" do
    @controller.log_in @user
    get :edit, id: @admin
    assert_auth_failed
  end

  test "should edit self when logged inas non-admin user" do
    @controller.log_in @user
    get :edit, id: @user
    assert_response :success
    assert_equal @user, assigns(:user)
  end

  ###########################
  # Update
  ###########################
  test "should update user when logged in as admin" do
    @controller.log_in @admin
    put :update, id: @user, user: { email: 'new@email.com' }
    assert_redirected_to show_cv_path(assigns(:user).username)
    assert_equal 'new@email.com', @user.reload.email
  end

  test "should not update user when not logged in" do
    refute @controller.logged_in?
    put :update, id: @user, user: { email: 'new@email.com' }
    assert_auth_failed
  end

  test "should not update other user when logged in as non-admin user" do
    @controller.log_in @user
    put :update, id: @admin, user: { email: 'new@email.com' }
    assert_auth_failed
  end

  test "should update self when logged in as non-admin user" do
    @controller.log_in @user
    put :update, id: @user, user: { email: 'new@email.com' }
    assert_redirected_to show_cv_path(assigns(:user).username)
    assert_equal 'new@email.com', @user.reload.email
  end

  ###########################
  # Destroy
  ###########################
  test "should destroy user when logged in as admin" do
    @controller.log_in @admin
    assert_difference 'User.count', -1 do
      delete :destroy, id: @user
      assert_redirected_to admin_users_path
    end
  end

  test "should not destroy user when not logged in" do
    refute @controller.logged_in?
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
      assert_auth_failed
    end
  end

  test "should not destroy user when logged in as non-admin user" do
    @controller.log_in @user
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
      assert_auth_failed
    end
  end
end
