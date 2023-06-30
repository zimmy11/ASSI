class Ban < ApplicationRecord
    belongs_to :user
    validates :user_id,:admin_id,presence:true
    validates :user_id,uniqueness:{scope: :admin_id}
    validate :admin_user

    def admin_user
      admin = User.find_by(id: admin_id, role: "admin")
      errors.add(:admin_id, "deve corrispondere a un utente con ruolo 'admin'") unless admin
    end
end 
