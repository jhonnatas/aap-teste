class Event < ApplicationRecord
  belongs_to :user

  validates :name, :local, :period_start, presence: true
end
