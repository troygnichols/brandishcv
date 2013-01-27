require 'test_helper'

class CvsControllerTest < ActionController::TestCase

  setup do
    @user = users(:bruce_lee)
    @admin = users(:admin)
  end

  test "should show cv when not logged in" do
    refute @controller.logged_in?
    get :show, username: @user.username
    assert_response :success
    assert_equal 'Current CV', assigns(:cv).markdown
  end

  test "should show cv when logged in as non-admin" do
    @controller.log_in @user
    get :show, username: @admin.username
    assert_response :success
    assert_equal 'I am the admin user', assigns(:cv).markdown
  end

  test "should show cv when logged in as admin" do
    @controller.log_in @admin
    get :show, username: @user.username
    assert_response :success
    assert_equal 'Current CV', assigns(:cv).markdown
  end

  test "should not edit when not logged in" do
    refute @controller.logged_in?
    get :edit, username: @user.username
    assert_auth_failed
  end

  test "should not edit other user's cv when logged in as non-admin" do
    @controller.log_in @user
    get :edit, username: @admin.username
    assert_auth_failed
  end

  test "should not edit other user's cv when logged in as admin" do
    @controller.log_in @admin
    get :edit, username: @user.username
    assert_auth_failed
  end

  test "should edit own cv when logged in as non-admin" do
    @controller.log_in @user
    get :edit, username: @user.username
    assert_response :success
  end

  test "should edit own cv when logged in as admin" do
    @controller.log_in @admin
    get :edit, username: @admin.username
    assert_response :success
  end

  test "should not update when not logged in" do
    refute @controller.logged_in?
    assert_no_difference 'Cv.count' do
      put :update, username: @user.username, cv: { markdown: 'blah blah blah' }
      assert_auth_failed
    end
  end

  test "should not update other user's cv when logged in as non-admin" do
    @controller.log_in @user
    assert_no_difference 'Cv.count' do
      put :update, username: @admin.username, cv: { markdown: 'blah blah blah' }
      assert_auth_failed
    end
  end

  test "should not update other user's cv when logged in as admin" do
    @controller.log_in @admin
    assert_no_difference 'Cv.count' do
      put :update, username: @user.username, cv: { markdown: 'blah blah blah' }
      assert_auth_failed
    end
  end

  test "should update own cv when logged in as non-admin" do
    @controller.log_in @user
    assert_difference 'Cv.count' do
      put :update, username: @user.username, cv: { markdown: 'blah blah blah' }
      assert_redirected_to show_cv_url(@user.username)
      updated = assigns(:cv)
      assert_equal 'blah blah blah', updated.markdown
      assert_equal 'blah blah blah', updated.reload.markdown
    end
  end

  test "should update own cv when logged in as admin" do
    @controller.log_in @admin
    assert_difference 'Cv.count' do
      put :update, username: @admin.username, cv: { markdown: 'blah blah blah' }
      assert_redirected_to show_cv_url(@admin.username)
      updated = assigns(:cv)
      assert_equal 'blah blah blah', updated.markdown
      assert_equal 'blah blah blah', updated.reload.markdown
    end
  end

end