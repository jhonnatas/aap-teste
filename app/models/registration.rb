class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum status: { pending: 'pending', confirmed: 'confirmed', cancelled: 'cancelled' }
end
