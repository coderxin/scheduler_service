# frozen_string_literal: true

class TimeSlot
  attr_reader :start_at, :index

  def initialize(start_at:, duration_in_seconds:, index:)
    @start_at = start_at
    @duration_in_seconds = duration_in_seconds
    @index = index
  end

  def digest
    Digest::SHA256.hexdigest(start_at.to_s)
  end

  def end_at
    start_at + duration_in_seconds
  end

  def overlaps?(other)
    start_at < other.end_at && other.start_at < end_at
  end

  def as_json(*)
    {
      index:,
      start_at:,
      end_at:
    }
  end

  private

  attr_reader :duration_in_seconds
end
