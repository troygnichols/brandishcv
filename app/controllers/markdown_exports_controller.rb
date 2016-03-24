class MarkdownExportsController < ApplicationController
  before_filter :load_user

  def generate
    md_file = "tmp/#{@user.username}.md"
    File.open md_file, 'w' do |md_file|
      md_file.puts @user.current_cv.markdown
    end
    send_file md_file, type: 'text/x-markdown', disposition: 'attachment'
  end

  private

  def load_user
    @user = User.where(username: params[:username]).first!
  end
end
