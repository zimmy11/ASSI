class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :ban, optional:true ,dependent: :destroy
  has_many :saves,dependent: :destroy
  has_many :org_events,dependent: :destroy
  has_many :presales,dependent: :destroy
  has_many :evaluations,dependent: :destroy
  has_many :drafts,dependent: :destroy
  has_many :bans, -> {where("role = ?", "admin") },dependent: :destroy
  has_many :events, :through => :org_events
  has_many :events, :through => :presales
  has_many :events, :through => :saves
  has_many :events, :through => :evaluations
  #validates :role, inclusion: { in: ["admin", "user", "organizer"] }
  validate :check_admin     

  validates :role, inclusion: { in: %w[user organizer] }
   
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
       

end
