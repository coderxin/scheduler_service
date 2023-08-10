# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ScheduleDecorator, type: :decorator do
  describe '#as_json' do
    it do
      time_slot_collection1 = instance_double(TimeSlotCollection, values: [1, 2, 3])
      time_slot_collection2 = instance_double(TimeSlotCollection, values: [4, 5])

      hash = {
        '2021-01-04' => time_slot_collection1,
        '2021-01-05' => time_slot_collection2
      }

      expect(described_class.new(hash).as_json('')).to eq([
                                                            { '2021-01-04' => [1, 2, 3] }, { '2021-01-05' => [4, 5] }
                                                          ])
    end
  end
end
