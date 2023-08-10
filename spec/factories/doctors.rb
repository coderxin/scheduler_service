# frozen_string_literal: true

FactoryBot.define do
  factory :doctor do
    first_name { 'John' }
    last_name { 'Doe' }

    trait :with_config do
      after(:create) do |doctor|
        create(:doctor_config, doctor:)
      end
    end
  end
end
