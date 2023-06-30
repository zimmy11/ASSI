class Ban < ApplicationRecord
    belongs_to :user
    belongs_to :admin,class_name: "User"
    validates :user_id,:admin_id,presence:true
    validates :user_id,uniqueness:{scope: :admin_id}
    validate :admin_user
    validate :print_errors
    validate :different_users
    def different_users
      if user_id == admin_id
        errors.add(:base,"Lo user_id deve essere diverso da admin_id")
      end
    end
    def admin_user
      admin = User.find_by(id: admin_id, role: "admin")
      if admin.nil?
        errors.add( :base,"l'admin_id deve corrispondere a un utente con ruolo 'admin'")
      end
    end
    def print_errors
      errors.full_messages.each do |message|
          puts message
    end
  end
end 
