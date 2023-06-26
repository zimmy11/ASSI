class Evaluation < ApplicationRecord
 
  validates :event_id,:user_id,:value,presence:true
  validates_uniqueness_of :event_id, scope: :user_id
  validates :value, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }, unless: -> { :value.nil? }
  
end


