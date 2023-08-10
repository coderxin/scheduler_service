# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Scheduler, type: :service do
  let(:service) { described_class.new(start_date:, end_date:, doctor:) }

  let(:start_date) { DateTime.parse('2021-01-04') }
  let(:end_date) { DateTime.parse('2021-01-05') }

  let(:doctor) { create(:doctor) }
  let!(:doctor_config) do
    create(
      :doctor_config,
      day_start_time: '11:00',
      day_end_time: '14:00',
      blocker_start_time: '12:00',
      blocker_end_time: '13:00',
      time_slot_duration_in_seconds: 30 * 60, # 30 minutes
      doctor:
    )
  end

  describe '.call' do
    subject(:call) { service.call }

    context 'when no appointments are given' do
      it do
        result = call

        allow(TimeSlotCollection).to receive(:new).with('2021-01-04', doctor_config).and_call_original
        allow(TimeSlotCollection).to receive(:new).with('2021-01-05', doctor_config).and_call_original

        expect(result['2021-01-04']).to be_kind_of(TimeSlotCollection)
        expect(result['2021-01-05']).to be_kind_of(TimeSlotCollection)
      end
    end

    context 'when appointments are given' do
      let(:doctor) { create(:doctor) }

      it do
        appointment = create(
          :appointment,
          start_at: DateTime.parse('2021-01-05 11:00:00 +0100'),
          end_at: DateTime.parse('2021-01-05 12:00:00 +0100'),
          doctor:
        )

        allow(TimeSlotCollection).to receive(:new).with('2021-01-04', doctor_config).and_call_original

        time_slot_collection = instance_double(TimeSlotCollection)
        allow(TimeSlotCollection).to receive(:new).with('2021-01-05', doctor_config).and_return(time_slot_collection)
        allow(time_slot_collection).to receive(:delete_by).with(appointment)

        call
      end
    end
  end
end
