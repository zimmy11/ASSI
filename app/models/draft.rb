class Draft < ApplicationRecord
    belongs_to :user, ->{ where( role: ["admin","organizer"])}
    validates :title,:date,presence:true
    validates :title,uniqueness:{scope: :date}
end
