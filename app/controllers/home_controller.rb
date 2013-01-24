class HomeController < ApplicationController
  def index
    redirect_to show_cv_url(current_user.username) if logged_in?
  end
end
