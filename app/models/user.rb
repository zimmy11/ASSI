class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :ban, optional:true ,dependent: :destroy
  has_many :saves,dependent: :destroy,class_name: "Save"
  has_many :presales,dependent: :destroy
  has_many :evaluations,dependent: :destroy
  has_many :drafts,dependent: :destroy
  has_many :bans,dependent: :destroy
  has_many :presale_events, through: :presales, :source => :event
  has_many :saved_events, through: :saves, :source => :event
  has_many :evaluated_events, through: :evaluations, :source => :event
  validate :print_errors
  validates :username,presence:true,uniqueness:true #non voglio avere utenti con lo stesso nome 

  validates :role, inclusion: { in: %w[user organizer admin] }
   
  
  def print_errors
      errors.full_messages.each do |message|
          puts message
    end
  end
       

end
