class Event < ApplicationRecord
    has_many :saves,dependent: :destroy
    has_many :org_events,dependent: :destroy
    has_many :presales,dependent: :destroy
    has_many :evaluations,dependent: :destroy

    has_many :organizers, :through => :org_events,:source => :user #relazione has_many through per accedere più rapidamente a user
    has_many :clients, :through => :presales,:source => :user
    has_many :users, :through => :saves,:source => :user
    has_many :evaluators, :through => :evaluations,:source => :user
    validates :organizers,presence:true   #cardinalità (1,n) tra user e org_events
    validates :price,:title,:date,:location,presence:true #prezzo,titolo,data,location attributi not null
    validates :title,uniqueness:true
    validate :Presales_init
    validate :print_errors
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
