class Event < ApplicationRecord
    has_many :saves,dependent: :destroy,class_name: "Save"
    has_many :presales,dependent: :destroy
    has_many :evaluations,dependent: :destroy
    #belongs_to :user
    has_many :clients, :through => :presales,:source => :user
    has_many :evaluators, :through => :evaluations,:source => :user
    validates :price,:title,:date,:location,:organizer_id,presence:true #prezzo,titolo,data,location attributi not null
    validates :title,uniqueness:true
    validate :organizer
    validate :Presales_init
    validate :print_errors
    before_save :AvgValue
    def Presales_init
        if self.limit.nil?
            self.limit=100
            self.presales_left = 100  
        else
            self.presales_left = self.limit

        end
    end
    def AvgValue
        self.avgvalue = Evaluation.where(user_id: :id).average(:value)
        if(self.avgvalue.nil?)
            self.avgvalue=0
        end
        
    end
    def print_errors
        errors.full_messages.each do |message|
          puts message
        end
    end
    
    def saved_by?(user)
        Save.exists?(user_id: user.id,event_id: id)
    end

    def organizer
        organizer = User.find_by(id: organizer_id, role: "admin") || User.find_by(id: organizer_id, role: "organizer")
        if organizer.nil?
            errors.add(:base, "deve corrispondere a un utente con ruolo 'organizer' o 'admin'") 
            puts errors.full_messages
        end
      end

    

end
