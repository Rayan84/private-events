class User < ApplicationRecord
  has_many :user_events, foreign_key: :attendee_id
  has_many :attended_events, through: :user_events
  has_many :created_events, foreign_key: :creator_id, class_name: 'Event'
  validates :username, presence: true, uniqueness: true
end
