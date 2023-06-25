class Ban < ApplicationRecord
   
    has_many :users
    has_many :users,->{ where( role: "admin")} #correggere
    validates :user_id,:admin_id,presence:true
    validates :user_id,uniqueness:{scope: :admin_id}
end
