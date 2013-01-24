require 'test_helper'

class CvTest < ActiveSupport::TestCase
  setup do
    @user = users(:bruce_lee)
  end

  test "user assocation required" do
    cv = Cv.new(markdown: "blah blah blah")
    assert_error_on cv, "User can't be blank"
  end

  test "update user cv" do
    assert_difference 'Cv.count', +1 do
      @user.update_cv!(Cv.new(markdown: 'new stuff'))
    end
    assert_equal 'new stuff', @user.current_cv.markdown
  end
end
