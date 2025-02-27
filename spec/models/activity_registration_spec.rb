# spec/models/activity_registration_spec.rb

require 'rails_helper'

RSpec.describe ActivityRegistration, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:status) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:activity) }
  end
end
