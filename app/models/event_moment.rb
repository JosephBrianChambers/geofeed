class EventMoment < ApplicationRecord
  belongs_to :event
  belongs_to :moment

  validates :event_id, presence: true
  validates :moments_id, presence: true
end
