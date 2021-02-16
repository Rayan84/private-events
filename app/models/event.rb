class Event < ApplicationRecord
  has_many :user_events, foreign_key: :attended_event_id
  has_many :attendees, through: :user_events
  belongs_to :creator, class_name: 'User'

  scope :past, -> (date = Date.today.to_s) {where("DATE < ?", date)}
  scope :upcoming, -> (date = Date.today.to_s) {where("DATE >= ?", date)}
end
