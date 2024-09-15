class Event < ApplicationRecord
  belongs_to :user
  has_many :registrations
  has_many :users, through: :registrations

  enum status: { registrations_open: 'registrations_open',
        event_in_progress: 'event_in_progress', event_closed: 'event_closed',
        cancelled: 'cancelled'}

  validates :name, :local, :period_start, presence: true
end
