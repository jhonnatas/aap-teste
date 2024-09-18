class Activity < ApplicationRecord
  belongs_to :event

  validates :name, :title, :speaker, :local, :certificate_hours, :period_start, presence: true
end
