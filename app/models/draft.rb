class Draft < ApplicationRecord
    belongs_to :user
    validates :title,:date,:user_id,presence:true
    validates :title,uniqueness:true
    def print_errors
        errors.full_messages.each do |message|
            puts message
      end
    end

end

