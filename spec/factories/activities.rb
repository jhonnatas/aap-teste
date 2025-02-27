FactoryBot.define do
  factory :activity do
    name { 'Workshop on Rails' }
    title { 'Advanced Rails Techniques' }
    speaker { 'Jane Doe' }
    local { 'Main Hall' }
    period_start { DateTime.now }
    period_end { DateTime.now + 2.hours }
    certificate_hours { '2' }
    subscriptions_open { true }
    association :event
  end
end
