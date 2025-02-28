# spec/factories/activity_registration_factory.rb


FactoryBot.define do
  factory :activity_registration do
    status { "pending" }

    association :user  # Supondo que você tenha um modelo User

    association :activity  # Supondo que você tenha um modelo Activity
  end
end
