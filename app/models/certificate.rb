class Certificate < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :certificate_number, presence: true, uniqueness: true

  before_validation :generate_certificate_number, on: :create

  private

  def generate_certificate_number
    self.certificate_number ||= "CERT-#{SecureRandom.hex(8)}"
  end

  def generate_calculate_hours
    # Assuming you have a method to calculate hours based on activities
    self.hours = user.activities.where(event_id: event.id).sum(:hours)
  end
end
