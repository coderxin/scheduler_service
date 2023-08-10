# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Appointment, type: :model do
  it { is_expected.to belong_to(:doctor) }

  describe '.in_interval' do
    let!(:appointment) { create(:appointment, :with_doctor) }

    context 'when appointment date is less than given date' do
      it { expect(described_class.in_interval(from_date: '2023-08-10', to_date: '2023-08-11')).to be_empty }
    end

    context 'when appointment date is within a range of a given date' do
      it { expect(described_class.in_interval(from_date: '2023-08-08', to_date: '2023-08-10')).to include(appointment) }
    end

    context 'when appointment date is greater than given date' do
      it { expect(described_class.in_interval(from_date: '2023-08-08', to_date: '2023-08-09')).to be_empty }
    end
  end
end
