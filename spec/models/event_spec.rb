require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:local) }
    it { is_expected.to validate_presence_of(:period_start) }
  end
  describe 'associations' do
    it { is_expected.to belong_to :user }
  end
end
