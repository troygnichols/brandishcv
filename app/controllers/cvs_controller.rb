class CvsController < ApplicationController
  filter_access_to :show, require: :read, context: :cvs

  before_filter :load_user
  before_filter :restrict_access, only: [:edit, :update]

  def show
    @cv = @user.current_cv
  end

  def edit
    @cv = @user.current_cv || @user.cvs.build
  end

  def update
    @cv = @user.cvs.build(markdown: params[:cv][:markdown])
    @user.update_cv!(@cv)
    redirect_to action: 'show'
  end

  private

    def load_user
      @user = User.find_by_username!(params[:username])
    end

    def restrict_access
      permission_denied unless @user && @user == current_user
    end
end