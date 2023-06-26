class Event < ApplicationRecord
    
    validates :price,:title,:date,:location,presence:true
    validates :title,uniqueness:true
    validate :Presales_init
    before_save :AvgValue
    def Presales_init
        if self.limit.nil?
            self.presales_left = 100  
        else
            self.presales_left = self.limit

        end
    end
    def AvgValue
        self.avgvalue = Evaluation.where(user_id: :id).average(:value)
        if(self.avgvalue.nil?)
            self.avgvalue=0
        end
        
    end
    

end
