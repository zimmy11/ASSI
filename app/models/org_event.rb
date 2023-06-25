class OrgEvent < ApplicationRecord
    has_many :events
    has_many :users,->{ where( role: ["admin","organizers"])}
    validates :event_id,:user_id,presence:true
    validates :event_id,uniqueness:{scope: :user_id}
end
