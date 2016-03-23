class User < ActiveRecord::Base
  has_secure_password

  has_many :cvs, dependent: :destroy

  before_save :downcase_username, :downcase_email, :create_remember_token

  before_validation :prevent_admin_change

  alias_attribute :admin?, :admin

  DISALLOWED_USERNAMES = %w(admin)

  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :username, presence: true, uniqueness: { case_sensitive: false }, exclusion: {
      in: DISALLOWED_USERNAMES,
      message: 'not allowed'
  }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL }
  validates :password, :length => { minimum: 10 }, :allow_nil => true
  validates :password_confirmation, :presence => true, :unless => Proc.new{ |user| user.password.blank? }

  def update_cv!(cv)
    prev = current_cv
    cvs << cv unless prev && prev.markdown == cv.markdown
    self.save!
  end

  def current_cv
    cvs.order("cvs.created_at desc").limit(1).first
  end

  def role_symbols
    roles = [:user]
    roles << :admin if admin?
    roles
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
    self
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver_now
  end

  def reset_password(new_password, new_confirmation)
    raise PasswordResetExpired if password_reset_sent_at < 2.hours.ago
    self.password = new_password
    self.password_confirmation = new_confirmation
    save
  end

  def to_s
    username || "[no username]"
  end

  private

    def downcase_username
      self.username = username.downcase
    end

    def downcase_email
      self.email = email.downcase
    end

    def prevent_admin_change
      # you'll have setup admin accounts at the database level
      unless new_record?
        errors.add(:admin, "status cannot be changed!") if admin_changed?
      end
    end

    def create_remember_token
      self.remember_token ||= SecureRandom.urlsafe_base64
    end
end

class PasswordResetExpired < Exception; end
