class Presale < ApplicationRecord
    
    validates :event_id,:user_id,presence:true
    validates :event_id,uniqueness:{scope: :user_id}
    validate  :updatePresales

    def updatePresales
        event=Event.find(event_id)

        event.presales_left--;
        if event.presales_left<0
            errors.add("Non è possibile acquistare altre prevendite")
        
        end
    end
end
