require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase

  setup do
    @user = users(:bruce_lee)
  end

  ###########################
  # Index
  ###########################

  test "should get index of all users" do
    get :index
    assert_response :success
  end

  ###########################
  # New
  ###########################
  test "should get new" do
    get :new
    assert_response :success
    assert assigns(:user)
  end

  ###########################
  # Create
  ###########################
  test "should create user" do
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

  ###########################
  # Show
  ###########################
  test "should show existing user" do
    get :show, id: @user
    assert_response :success
    assert_equal @user, assigns(:user)
  end

  ###########################
  # Edit
  ###########################
  test "should get edit" do
    get :edit, id: @user
    assert_response :success
    assert_equal @user, assigns(:user)
  end

  ###########################
  # Update
  ###########################
  test "should update user" do
    put :update, id: @user, user: { email: 'new@email.com' }
    assert_redirected_to show_cv_path(assigns(:user).username)
    assert_equal 'new@email.com', @user.reload.email
  end

  ###########################
  # Destroy
  ###########################
  test "should destroy user" do
    assert_difference 'User.count', -1 do
      delete :destroy, id: @user
      assert_redirected_to admin_users_path
    end
  end
end
