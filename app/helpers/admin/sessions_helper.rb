module Admin::SessionsHelper

  def log_in(user)
    raise "cannot log in nobody (no user given)" unless user
    self.current_user = user
    keep_session_alive
    user
  end

  def log_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def keep_session_alive
    if logged_in?
      cookies[:remember_token] = {
          value: current_user.remember_token,
          expires: expiration_for(current_user)
      }
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def expiration_for(user)
    # login always permanent for now
    20.years.from_now
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    # "memoize" the current user - only go to the database for it if @current_user is empty
    @current_user ||= cookies[:remember_token].nil? ? nil :User.find_by_remember_token(cookies[:remember_token])
  end

end