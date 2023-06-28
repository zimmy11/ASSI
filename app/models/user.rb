class User < ApplicationRecord
  belongs_to :ban, optional:true ,dependent: :destroy
  has_many :saves,dependent: :destroy
  has_many :org_events,dependent: :destroy
  has_many :presales,dependent: :destroy
  has_many :evaluations,dependent: :destroy
  has_many :drafts,dependent: :destroy
  has_many :bans,if: :admin?,dependent: :destroy
  has_many :events, :through => :org_events
  has_many :events, :through => :presales
  has_many :events, :through => :saves
  has_many :events, :through => :evaluations
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
  def print_errors
    errors.full_messages.each do |message|
      puts message
    end



end
