# frozen_string_literal: true

FactoryBot.define do
  factory :appointment do
    start_at { '2023-08-09 13:30:00 UTC'.to_time }
    end_at { '2023-08-09 14:00:00 UTC'.to_time }

    trait :with_doctor do
      association :doctor
    end
  end
end
