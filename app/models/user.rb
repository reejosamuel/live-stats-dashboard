class User < ApplicationRecord
  enum role: [:investor, :accounts, :management, :sales]

  after_initialize :set_default_role, :if => :new_record?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def set_default_role
    self.role ||= :sales
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end

end
