class Draft < ApplicationRecord
    belongs_to :user
    validates :title,:date,:user_id,presence:true
    validates :title,uniqueness:{scope: :date}
    validate :organizer

    def organizer
      organizer = User.find_by(id: user_id, role: "admin") || User.find_by(id: user_id, role: "organizer")  
      errors.add(:user_id, "deve corrispondere a un utente con ruolo 'organizer' o 'admin'") unless organizer
      puts errors.full_messages
    end

end

