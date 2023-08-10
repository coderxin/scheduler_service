# frozen_string_literal: true

class Doctor < ApplicationRecord
  has_one :doctor_config, dependent: :destroy
  has_many :appointments, dependent: :destroy
end
