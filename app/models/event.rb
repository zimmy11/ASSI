class Event < ApplicationRecord
    has_many :saves,class_name: "Save",dependent: :destroy
    has_many :org_events,dependent: :destroy
    has_many :presales,dependent: :destroy
    has_many :evaluations,dependent: :destroy
    has_many :users, :through => :org_events
    has_many :users, :through => :presales
    has_many :users, :through => :saves
    has_many :users, :through => :evaluations
    validates :price,:title,:date,:location,presence:true
    validates :title,uniqueness:true
    validate :Presales_init
    before_save :AvgValue

    def Presales_init
        if self.limit.nil?
            self.limit=100
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
    def print_errors
        errors.full_messages.each do |message|
          puts message
        end
    end
    

end
