# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TimeSlot, type: :service do
  let(:service) { described_class.new(start_at:, duration_in_seconds:, index:) }

  let(:start_at) { '2021-01-04 10:00:00 UTC'.to_time }
  let(:duration_in_seconds) { 1800 }
  let(:index) { 5 }

  describe '#as_json' do
    subject(:as_json) { service.as_json('') }

    it do
      expect(as_json).to eq({
                              index: 5,
                              start_at: '2021-01-04 10:00:00 UTC'.to_time,
                              end_at: '2021-01-04 10:30:00 UTC'.to_time
                            })
    end
  end

  describe '#digest' do
    subject(:digest) { service.digest }

    it { expect(digest).to eq('522131c5a3f5fed91351d741f95660ea0366460dfc1a52c2dfe6df084b5bb172') }
  end

  describe '#end_at' do
    subject(:end_at) { service.end_at }

    it { expect(end_at).to eq('2021-01-04 10:30:00 UTC'.to_time) }
  end

  describe '#overlaps?' do
    subject(:overlaps) { service.overlaps?(other) }

    context 'when slots are identically matching' do
      let(:other) do
        OpenStruct.new(
          start_at: '2021-01-04 10:00:00 UTC'.to_time,
          end_at: '2021-01-04 10:30:00 UTC'.to_time
        )
      end

      it { expect(overlaps).to be_truthy }
    end

    context 'when slots are fully matching' do
      let(:other) do
        OpenStruct.new(
          start_at: '2021-01-04 09:30:00 UTC'.to_time,
          end_at: '2021-01-04 11:00:00 UTC'.to_time
        )
      end

      it { expect(overlaps).to be_truthy }
    end

    context 'when slots are not matching (before)' do
      let(:other) do
        OpenStruct.new(
          start_at: '2021-01-04 09:30:00 UTC'.to_time,
          end_at: '2021-01-04 10:00:00 UTC'.to_time
        )
      end

      it { expect(overlaps).to be_falsey }
    end

    context 'when slots are not matching (after)' do
      let(:other) do
        OpenStruct.new(
          start_at: '2021-01-04 10:30:00 UTC'.to_time,
          end_at: '2021-01-04 11:00:00 UTC'.to_time
        )
      end

      it { expect(overlaps).to be_falsey }
    end

    context 'when slots are matching (partially)' do
      let(:other) do
        OpenStruct.new(
          start_at: '2021-01-04 10:15:00 UTC'.to_time,
          end_at: '2021-01-04 10:30:00 UTC'.to_time
        )
      end

      it { expect(overlaps).to be_truthy }
    end
  end
end
