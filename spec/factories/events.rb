FactoryBot.define do
  factory :event do
    name { 'Conference' }
    local { 'New York' }
    period_start { Date.today }
    period_end { Date.today + 2.days }
    association :user
  end
end
