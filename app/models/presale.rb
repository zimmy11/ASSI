class Presale < ApplicationRecord
    belongs_to :user
  belongs_to :event
    validates :event_id,:user_id,presence:true
    validates :event_id,uniqueness:{scope: :user_id}
    validate  :updatePresales

    def updatePresales
        event=Event.find(event_id)
        
        event.presales_left--
        if event.presales_left<0
            errors.add("Non è possibile acquistare altre prevendite")
            puts errors.full_messages
        end
    end
end
