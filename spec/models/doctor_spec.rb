# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Doctor, type: :model do
  subject { build(:doctor) }

  it { is_expected.to have_one(:doctor_config) }
  it { is_expected.to have_many(:appointments) }
end
