# frozen_string_literal: true

module Api
  module V1
    module Doctors
      class BaseController < ApplicationController
        before_action :find_doctor

        private

        def find_doctor
          @doctor = Doctor.find(params[:doctor_id])
        end
      end
    end
  end
end
