# frozen_string_literal: true

class Appointment < ApplicationRecord
  belongs_to :doctor

  scope :in_interval, lambda { |from_date:, to_date:|
    where('start_at >= :from_date AND end_at < :to_date', from_date:, to_date:)
  }
end
