module CustomAssertions
  def assert_valid(model)
    assert model.valid?, "Expected model to be valid, but had errors: #{model.errors.full_messages}, #{model}"
  end

  def assert_error_on(model, msg)
    refute model.valid?, "Model was valid but expected error: #{msg}"
    errors = model.errors.full_messages
    assert errors.include?(msg), "Wrong errors(s): #{errors}, expected: #{msg}"
  end

  def assert_auth_failed
    assert_equal "Access denied.", flash[:error], "Expected access denied flash message, but was: #{flash[:error]}"
    assert_redirected_to root_path
  end
end
