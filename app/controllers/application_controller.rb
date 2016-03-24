class ApplicationController < ActionController::Base
  include Admin::SessionsHelper

  protect_from_forgery

  before_action { |controller| Authorization.current_user = controller.current_user }

  def permission_denied
    logger.info "Access denied for user: #{current_user}, on: #{params[:controller]}:#{params[:action]}"
    respond_to do |format|
      format.html do
        flash[:error] = "Access denied."
        redirect_to root_url
      end
      format.json { head :unauthorized }
      format.xml { head :unauthorized }
    end
  end

  private

    DEFAULT_PAGE = 1
    DEFAULT_PER_PAGE = 10

    def page
      params[:page] || DEFAULT_PAGE
    end

    def per_page
      params[:per_page] || DEFAULT_PER_PAGE
    end
end
