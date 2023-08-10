# frozen_string_literal: true

class Scheduler
  def initialize(start_date:, end_date:, doctor:)
    @start_date = start_date
    @end_date = end_date
    @doctor = doctor
  end

  def call
    time_slots_hash = {}

    interval_dates.each { |date| time_slots_hash[date] = TimeSlotCollection.new(date, doctor.doctor_config) }

    appointments = doctor.appointments.in_interval(from_date: start_date, to_date: end_date.next_day)

    # Remove time_slots overlapping with appointments
    appointments.find_each do |appointment|
      scope = appointment.start_at.strftime('%Y-%m-%d')
      time_slots_hash[scope].delete_by(appointment)
    end

    time_slots_hash
  end

  private

  attr_reader :start_date, :end_date, :doctor

  def interval_dates
    @interval_dates ||= start_date.upto(end_date).map { |date| date.strftime('%Y-%m-%d') }
  end
end
