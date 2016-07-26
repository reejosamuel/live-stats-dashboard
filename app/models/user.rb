class User < ApplicationRecord
  enum role: [:investor, :accounts, :management, :sales]

  after_initialize :set_default_role, :if => :new_record?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Mobile
  validates :mobile, presence: true
  validates :mobile, uniqueness: true
  validates :mobile, format: { with: /\A05\d{8}\z/, message: "must be valid UAE number. e.g. 0504567123" }
  #   validates :mobile, length: { is: 10 }

  # Name
  validates :first_name, presence: true
  validates :last_name, presence: true

  def set_default_role
    self.role ||= :sales
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def full_name
    "#{first_name} #{last_name}"
  end


  # Override the default token generation for 5 Digit code
  def generate_confirmation_token
    if self.confirmation_token && !confirmation_period_expired?
      @raw_confirmation_token = self.confirmation_token
    else
      self.confirmation_token = @raw_confirmation_token = random_five_digits
      self.confirmation_sent_at = Time.now.utc
    end
  end

  def random_five_digits
    rand.to_s[2..6]
  end

end
