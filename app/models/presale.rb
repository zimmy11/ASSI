class Presale < ApplicationRecord
  

    belongs_to :user
    belongs_to :event
    validates :event_id,:user_id,presence:true
    validate  :updatePresales
    validate :print_errors
    def updatePresales
        event=Event.find_by(id: self.event_id)
        puts event
        if event.nil?
            errors.add(:base, "Evento non trovato")
            return
        end
        presales_left=event.presales_left-1
        event.update(presales_left: presales_left)
        if event.presales_left<0
            errors.add("Non è possibile acquistare altre prevendite")
            puts errors.full_messages
        end
    end
    def print_errors
        errors.full_messages.each do |message|
            puts message
      end
    end
   
    
end
