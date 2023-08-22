class Event < ApplicationRecord
    has_many :saves,dependent: :destroy,class_name: "Save"
    has_many :presales
    has_many :evaluations,dependent: :destroy
    belongs_to :user,foreign_key: :organizer_id
    has_many :clients, :through => :presales,:source => :user
    has_many :evaluators, :through => :evaluations,:source => :user
    validates :price,:date,:location,:organizer_id,presence:true, if: :published? #prezzo,titolo,data,location attributi not null
    validates :title,presence: :true
    validates_uniqueness_of :title,scope: [:status] #non voglio due bozze con lo stesso titolo o due eventi con lo stesso titolo
    validates_uniqueness_of :location,scope:[:status, :date], if: :published?
    validate :organizer
    validate :Presales_init
    validate :print_errors
    validate :AvgValue
    validate :date_cannot_be_in_the_past
    enum status: { draft: 'draft', published: 'published' }

    def published?
        status == 'published'
      end

    def Presales_init
        if self.limit.nil?
            self.limit=100
            self.presales_left = 100  
        else
            self.presales_left = self.limit

        end
    end

    def date_cannot_be_in_the_past
        if date.present? && date <= Date.today
          errors.add(:date, "deve essere maggiore della data odierna")
        end
    end

    def AvgValue
        self.avgvalue ||= 0.0
    end

    def print_errors
        errors.full_messages.each do |message|
          puts message
        end
    end
    
    def saved_by?(user)
        Save.exists?(user_id: user.id,event_id: id)
    end

    def self.filter(filter_criteria)
        # Logica di filtraggio basata sui criteri passati come parametro.
        # Esempio di implementazione:
        filtered_events = all

        if filter_criteria[:location].present?
            # Filtro per la località solo se è stata specificata nei criteri di ricerca
            filtered_events = filtered_events.where(location: filter_criteria[:location])
          end
    
        if filter_criteria[:avgvalue_min].present?
            filtered_events = filtered_events.where('avgvalue >=', filter_criteria[:avgvalue_min])
        end
    
        if filter_criteria[:price_min].present?
            filtered_events = filtered_events.where('price >= ?', filter_criteria[:price_min])
        end
    
        if filter_criteria[:price_max].present?
            filtered_events = filtered_events.where('price <= ?', filter_criteria[:price_max])
        end
    
        filtered_events
      end

    def organizer
        organizer = User.find_by(id: organizer_id, role: "admin") || User.find_by(id: organizer_id, role: "organizer")
        if organizer.nil?
            errors.add(:base, "deve corrispondere a un utente con ruolo 'organizer' o 'admin'") 
            
        end
      end
    
      

    

end
