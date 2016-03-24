require 'docx'

class DocxExportsController < ApplicationController
  before_filter :load_user

  def generate
    docx = Docx.from_markdown @user.current_cv
    send_file docx, type: 'application/doc', disposition: 'attachment'
  end

  private

  def load_user
    @user = User.where(username: params[:username]).first!
  end
end
