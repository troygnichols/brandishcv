require 'pdf'

class PdfExportsController < ApplicationController
  before_filter :load_user

  def generate
    pdf = Pdf.from_markdown @user.current_cv
    send_file pdf, type: 'application/pdf', disposition: 'inline'
  end

  private

  def load_user
    @user = User.where(username: params[:username]).first!
  end
end
