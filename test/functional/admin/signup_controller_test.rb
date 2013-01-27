require 'test_helper'

class Admin::SignupControllerTest < ActionController::TestCase

  test "sign up with valid info creates user account and logs in" do
    assert_difference 'User.count', +1 do
      refute @controller.logged_in?
      post :create, user: { username: 'newguy', email: 'newguy@email.com',
                            password: 'mypassword', password_confirmation: 'mypassword' }
      assert @controller.logged_in?
      assert_equal assigns(:user), @controller.current_user
    end
  end
end