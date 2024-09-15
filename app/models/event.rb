class Event < ApplicationRecord
  enum status: { registrations_open: 'registrations_open',
        event_in_progress: 'event_in_progress', event_closed: 'event_closed',
        cancelled: 'cancelled'}
  belongs_to :user

  validates :name, :local, :period_start, presence: true
end
