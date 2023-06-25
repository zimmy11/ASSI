class Event < ApplicationRecord
    has_many :saves
    has_many :presales
    has_many :evaluations
    has_many :org_events
    validates :price,:title,:date,:location,presence:true
    validates :title,uniqueness:true
end
