# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DoctorConfig, type: :model do
  it { is_expected.to belong_to(:doctor) }
end
