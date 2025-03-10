FactoryBot.define do
  factory :registration do
    status { 'pending' }
    user
    event
  end
end
