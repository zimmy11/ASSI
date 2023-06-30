class Save < ApplicationRecord
    belongs_to :user
    belongs_to :event
    validates :event_id,:user_id,presence:true
    validates :event_id,uniqueness:{scope: :user_id}
    validate :print_errors
    def print_errors
        errors.full_messages.each do |message|
            puts message
      end
    end
end
