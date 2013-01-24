require 'test_helper'

class HomeControllerTest < ActionController::TestCase

  setup do
    @admin = users(:admin)
    @user = users(:bruce_lee)
  end

  test "home index goes to home page when not logged in" do
    refute @controller.logged_in?
    get :index
    assert_response :success
    assert_template :index
  end

  test "home index redirects to user's current CV page when logged in as regular user" do
    @controller.log_in @user
    get :index
    assert_redirected_to show_cv_path(@user.username)
  end

  test "home index redirects to user's current CV page when logged in as admin user" do
    @controller.log_in @admin
    get :index
    assert_redirected_to show_cv_path(@admin.username)
  end

end