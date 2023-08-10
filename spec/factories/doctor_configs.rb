# frozen_string_literal: true

FactoryBot.define do
  factory :doctor_config do
    day_start_time { '08:00' }
    day_end_time { '18:00' }
    blocker_start_time { '12:00' }
    blocker_end_time { '13:00' }
    time_slot_duration_in_seconds { 30 * 60 } # 30 minutes
  end
end
