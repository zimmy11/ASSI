class User < ApplicationRecord
  belongs_to :ban, optional:true ,dependent: :destroy
  has_many :saves,dependent: :destroy
  has_many :org_events,dependent: :destroy
  has_many :presales,dependent: :destroy
  has_many :evaluations,dependent: :destroy
  has_many :drafts,dependent: :destroy
  has_many :bans,if: :admin?,dependent: :destroy
 
  validates :role, inclusion: { in: ['admin', 'user', 'organizer'] }
  
  def admin?
    role == 'admin'
  end
  validates :email,:password,:user_id,:role,presence:true
  validates :user_id,uniqueness:true
  validate :check_admin
  def check_admin
    if  Ban.where(admin_id: :id).present? && !admin?
      errors.add(:base, "Only admins can have bans")
    end
  end



end
