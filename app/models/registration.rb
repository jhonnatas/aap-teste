class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum status: { pending: 'pending', confirmed: 'confirmed', cancelled: 'cancelled' }

  
  scope :for_user_and_event, -> ( user, event ){ where( user: user, event: event ) }
end
