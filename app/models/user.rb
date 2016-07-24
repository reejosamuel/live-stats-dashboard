class User < ApplicationRecord
  enum role: [:investor, :accounts, :management, :sales]

  after_initialize :set_default_role, :if => :new_record?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :mobile, presence: true
  validates :mobile, uniqueness: true
  validates :mobile, format: { with: /\A05\d{8}\z/, message: "must be valid UAE number. e.g. 0504567123" }
  #   validates :mobile, length: { is: 10 }

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

end
