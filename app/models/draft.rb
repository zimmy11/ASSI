class Draft < ApplicationRecord
    belongs_to :user
    validates :title,:date,presence:true
    validates :title,uniqueness:{scope: :date}
    validate :organizer

    def organizer
      organizer = User.find_by(id: users_id, role: "admin") || User.find_by(id: users_id, role: "organizer")  
      errors.add(:users_id, "deve corrispondere a un utente con ruolo 'organizer' o 'admin'") unless organizer
     puts errors.full_messages
    end
end

