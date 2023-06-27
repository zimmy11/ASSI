class OrgEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event
    validates :event_id,:user_id,presence:true
    validates :event_id,uniqueness:{scope: :user_id}
    validate :organizer

    def organizer
      organizer = User.find_by(id: user_id, role: "admin") || User.find_by(id: user_id, role: "organizer")  
      errors.add(:user_id, "deve corrispondere a un utente con ruolo 'organizer' o 'admin'") unless organizer
     puts errors.full_messages
    end
end
