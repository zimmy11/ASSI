class Evaluation < ApplicationRecord
  belongs_to :user
  belongs_to :event
  validates :event_id,:user_id,:value,presence:true
  validates_uniqueness_of :event_id, scope: :user_id
  validates :value, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }, unless: -> { :value.nil? }
  validate :print_errors
  def print_errors
    errors.full_messages.each do |message|
        puts message
  end
end
end


