class User < ApplicationRecord
  has_many :drafts
  has_many :saves
  has_many :org_events
  has_many :presales
  has_many :evaluations
  has_many :bans
  belongs_to :ban, optional:true 
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
