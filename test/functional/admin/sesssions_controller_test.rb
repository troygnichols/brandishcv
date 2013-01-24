require 'test_helper'

class Admin::SessionsControllerTest < ActionController::TestCase

  setup do
    @where_from = @request.env['HTTP_REFERER'] = 'http://test.com/sessions/new'
    @admin = users(:admin)
    @user = users(:bruce_lee)
  end

  test "login as regular user with valid email and password should succeed" do
    refute @controller.logged_in?
    post :create, username_or_email: @user.email, password: 'trustno1hunter2'
    assert @controller.logged_in?
    assert_equal @user, @controller.current_user
    assert_redirected_to root_path
  end

  test "login as regular user with valid email and bad password should fail" do
    refute @controller.logged_in?
    post :create, username_or_email: @user.email, password: 'badpass'
    refute @controller.logged_in?
    assert_redirected_to @where_from
  end

  test "login as regular user with valid username and password should succeed" do
    refute @controller.logged_in?
    post :create, username_or_email: @user.username, password: 'trustno1hunter2'
    assert @controller.logged_in?
    assert_equal @user, @controller.current_user
    assert_redirected_to root_path
  end

  test "login as regular user with valid username and bad password should fail" do
    refute @controller.logged_in?
    post :create, username_or_email: @user.username, password: 'badpass'
    refute @controller.logged_in?
    assert_redirected_to @where_from
  end

end