# frozen_string_literal: true

module Api
  module V1
    module Doctors
      class AppointmentsController < BaseController
        def index
          render json: { data: @doctor.appointments }
        end
      end
    end
  end
end
