class EventHall < ApplicationRecord
  belongs_to :event
  has_many :hall_details, dependent: :destroy

  accepts_nested_attributes_for :hall_details
end
