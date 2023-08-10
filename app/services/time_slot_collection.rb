# frozen_string_literal: true

class TimeSlotCollection
  delegate \
    :day_start_time, :day_end_time,
    :blocker_start_time, :blocker_end_time,
    :time_slot_duration_in_seconds,
    to: :config

  def initialize(date, config)
    @date = date
    @config = config
    @time_slots_hash = {}

    build_daily_time_slots
  end

  delegate :values, to: :time_slots_hash

  def delete_by(time_slot)
    blocked_time_slots = time_slots_hash.values.find_all { |ts| ts.overlaps?(time_slot) }
    blocked_time_slots.each { |ts| time_slots_hash.delete(ts.digest) }
  end

  private

  attr_accessor :time_slots_hash
  attr_reader :date, :config

  def build_daily_time_slots
    start_at = utc_time("#{date} #{day_start_time}")
    end_at = utc_time("#{date} #{day_end_time}")

    hour = start_at
    index = 1

    while hour < end_at
      time_slot = build_time_slot(hour, index)

      time_slots_hash[time_slot.digest] = time_slot unless time_slot.overlaps?(blocked_time_slot)

      index += 1
      hour += time_slot_duration_in_seconds
    end
  end

  def build_time_slot(start_at, index)
    TimeSlot.new(
      index:,
      start_at:,
      duration_in_seconds: time_slot_duration_in_seconds
    )
  end

  def blocked_time_slot
    @blocked_time_slot ||= begin
      blocker_start_at = utc_time("#{date} #{blocker_start_time}")
      blocker_end_at = utc_time("#{date} #{blocker_end_time}")

      OpenStruct.new(start_at: blocker_start_at, end_at: blocker_end_at)
    end
  end

  def utc_time(string)
    string.to_time.utc
  end
end
