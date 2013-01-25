class Admin::PagesController < ApplicationController
  def show
    render "admin/pages/#{params[:page]}"
  end
end