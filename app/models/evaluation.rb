class Evaluation < ApplicationRecord
  has_many :events
  has_many :users
  validates :event_id,:user_id,presence:true
  validates :event_id,uniqueness:{scope: :user_id}
  validates :value, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }

end
