class UserMailer < ActionMailer::Base
  default from: 'no-reply@brandishcv.net'

  def password_reset(user)
    @password_reset_url = edit_admin_password_reset_url(user.password_reset_token)
    mail to: user.email, subject: 'Password Reset Requested'
  end
end
