class User < ApplicationRecord
  belongs_to :ban, optional:true 
  validates :role, inclusion: { in: ['admin', 'user', 'organizer'] }

  def admin?
    role == 'admin'
  end
  validates :email,:password,:user_id,:role,presence:true
  validates :user_id,uniqueness:true
  validate :check_admin
  def check_admin
    if bans.present? && !admin?
      errors.add(:base, "Only admins can have bans")
    end
  end



end
