class Evaluation < ApplicationRecord
  belongs_to :user
  belongs_to :event
  validates :event_id,:user_id,:value,presence:true
  validates_uniqueness_of :event_id, scope: :user_id
  validates :value, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }, unless: -> { :value.nil? }
  validate :print_errors
  after_destroy :update_avgvalue

  def update_avgvalue
    event.update_attribute(:avgvalue,Evaluation.where(event_id: event.id).average(:value))
    if event.avgvalue == nil 
      event.update_attribute(:avgvalue,0.0)
    end

  end
  def print_errors
    errors.full_messages.each do |message|
        puts message
  end
end
end


