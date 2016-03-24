class CvsController < ApplicationController
  filter_access_to :show, require: :read, context: :cvs

  before_action :load_user
  before_action :restrict_access, only: [:edit, :update]

  def show
    @cv = @user.current_cv
  end

  def edit
    @cv = @user.current_cv || @user.cvs.build(markdown: default_markdown_template)
  end

  def update
    @cv = @user.cvs.build(markdown: params[:cv][:markdown])
    @user.update_cv!(@cv)
    redirect_to action: 'show'
  end

  private

    def load_user
      @user = User.find_by(username: params[:username])
      redirect_to root_path unless @user
    end

    def restrict_access
      permission_denied unless @user && @user == current_user
    end

    def default_markdown_template
      <<-EOS.chomp
# #{current_user.try(:username) || '[Your name here]'}
#### #{current_user.try(:email) || 'your.email@example.com'}

-----

### Your info here...
      EOS
    end
end
