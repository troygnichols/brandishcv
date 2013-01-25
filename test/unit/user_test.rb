require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:bruce_lee)
  end

  test "create user" do
    assert_difference 'User.count', +1 do
      User.new(
          username: 'donvanvliet',
          email: 'captain.beefheart@magicband.net',
          password: 'mypassword',
          password_confirmation: 'mypassword'
      ).save!
    end
  end

  test "email cannot be duplicate" do
    dup = @user.dup
    assert_error_on dup, "Email has already been taken"
  end

  test "email cannot be duplicate ignoring case" do
    @user.email = @user.email.downcase
    @user.save!
    dup = @user.dup
    dup.email = @user.email.upcase
    assert_error_on dup, "Email has already been taken"
  end

  test "username cannot be duplicate" do
    dup = @user.dup
    assert_error_on dup, "Username has already been taken"
  end

  test "username canot be duplicate ignoring case" do
    @user.username = @user.username.downcase
    @user.save!
    dup = @user.dup
    dup.username = @user.username.upcase
    assert_error_on dup, "Username has already been taken"
  end

  test "destroy user" do
    assert_difference 'User.count', -1 do
      @user.destroy
    end
  end

  test "destroy user destroys associated cvs" do
    assert @user.cvs.count > 0
    assert_difference 'User.count', -1 do
      assert_difference 'Cv.count', -(@user.cvs.count) do
        @user.destroy
      end
    end
  end

  test "current_cv returns most recently created cv for this user" do
    assert_equal cvs(:bruce_lee_current), @user.current_cv
  end

  test "current_cv returns nil without error when no cvs for this user" do
    @user.cvs.destroy_all
    assert_equal 0, @user.cvs.count
    assert_nil @user.current_cv
  end

  test "username cannot be 'admin'" do
    @user.username = 'admin'
    assert_error_on @user, 'Username not allowed'
  end

  test "email can be valid email address" do
    @user.email = "abcdef_1235@somewhere.org"
    assert_valid @user
  end

  test "email cannot be invalid email address" do
    @user.email = "not.valid@badtld"
    assert_error_on @user, "Email is invalid"
  end

  test "username downcased on save" do
    @user.username = "NEWUSER"
    @user.save!
    assert_equal "newuser", @user.username
    assert_equal "newuser", @user.reload.username
  end

  test "email downcased on save" do
    @user.email = "NEW@EMAIL.COM"
    @user.save!
    assert_equal "new@email.com", @user.email
    assert_equal "new@email.com", @user.reload.email
  end

  test "admin status cannot be changed" do
    assert_equal false, @user.admin?
    @user.admin = true
    refute @user.save
    assert_error_on @user, "Admin status cannot be changed!"
  end
end
