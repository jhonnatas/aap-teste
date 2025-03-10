class ActivityRegistration < ApplicationRecord
  belongs_to :user
  belongs_to :activity

  enum :status, { pending: "pending", confirmed: "confirmed", cancelled: "cancelled" }

  validates :status, presence: true

  # scope :for_user_and_activity, -> (user, activity) { where( user: user, activity: activity) }
end
