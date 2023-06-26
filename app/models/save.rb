class Save < ApplicationRecord
   
    validates :event_id,:user_id,presence:true
    validates :event_id,uniqueness:{scope: :user_id}
end
