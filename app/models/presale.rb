class Presale < ApplicationRecord
    has_many :events
    has_many :users
    validates :event_id,:user_id,presence:true
    validates :event_id,uniqueness:{scope: :user_id}
    
end
