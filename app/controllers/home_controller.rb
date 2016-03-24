class HomeController < ApplicationController
  include ApplicationHelper

  def index
    flash.keep
    redirect_to show_cv_url(current_user.username) if logged_in?

    @random_username = random_username
  end
end
