# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TimeSlotCollection, type: :service do
  let(:service) { described_class.new(date, config) }

  let(:date) { '2021-01-04' }
  let(:config) do
    OpenStruct.new(
      day_start_time: '11:00',
      day_end_time: '14:00',
      blocker_start_time: '12:00',
      blocker_end_time: '13:00',
      time_slot_duration_in_seconds: 30 * 60 # 30 minutes
    )
  end

  describe '#values' do
    subject(:values) { service.values }

    it do
      result = values

      expect(result.size).to eq(4)

      time_slot1 = result[0]
      expect(time_slot1).to be_kind_of(TimeSlot)
      expect(time_slot1.start_at).to eq('2021-01-04 10:00:00 UTC'.to_time)
      expect(time_slot1.end_at).to eq('2021-01-04 10:30:00 UTC'.to_time)
      expect(time_slot1.index).to eq(1)

      time_slot2 = result[1]
      expect(time_slot2).to be_kind_of(TimeSlot)
      expect(time_slot2.start_at).to eq('2021-01-04 10:30:00 UTC'.to_time)
      expect(time_slot2.end_at).to eq('2021-01-04 11:00:00 UTC'.to_time)
      expect(time_slot2.index).to eq(2)

      time_slot3 = result[2]
      expect(time_slot3).to be_kind_of(TimeSlot)
      expect(time_slot3.start_at).to eq('2021-01-04 12:00:00 UTC'.to_time)
      expect(time_slot3.end_at).to eq('2021-01-04 12:30:00 UTC'.to_time)
      expect(time_slot3.index).to eq(5)

      time_slot4 = result[3]
      expect(time_slot4).to be_kind_of(TimeSlot)
      expect(time_slot4.start_at).to eq('2021-01-04 12:30:00 UTC'.to_time)
      expect(time_slot4.end_at).to eq('2021-01-04 13:00:00 UTC'.to_time)
      expect(time_slot4.index).to eq(6)
    end
  end

  describe '#delete_by' do
    subject(:delete_by) { service.delete_by(time_slot) }

    let(:time_slot) do
      OpenStruct.new(
        start_at: '2021-01-04 12:30:00 UTC'.to_time,
        end_at: '2021-01-04 13:30:00 UTC'.to_time
      )
    end

    it do
      delete_by

      expect(service.values.size).to eq(3)
    end
  end
end
