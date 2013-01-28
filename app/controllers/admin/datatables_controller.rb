class Admin::DatatablesController < ApplicationController
  filter_access_to :users, require: :manage, context: :admin_users

  def users
    render json: UsersDatatable.new(view_context)
  end
end