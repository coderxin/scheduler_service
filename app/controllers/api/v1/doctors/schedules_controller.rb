# frozen_string_literal: true

module Api
  module V1
    module Doctors
      class MissingParameterError < StandardError; end

      class SchedulesController < BaseController
        rescue_from ActionController::ParameterMissing, MissingParameterError do |exception|
          render json: { error: exception }, status: :bad_request
        end

        def show
          available_time_slots = ::Scheduler.new(
            doctor: @doctor,
            start_date: schedule_from_date,
            end_date: schedule_to_date
          ).call

          render json: { data: ScheduleDecorator.new(available_time_slots) }
        end

        private

        def schedule_from_date
          unless schedule_params[:from_date]
            raise MissingParameterError, 'Please provide schedule[from_date] parameter to proceed'
          end

          DateTime.parse(schedule_params[:from_date])
        end

        def schedule_to_date
          unless schedule_params[:to_date]
            raise MissingParameterError, 'Please provide schedule[to_date] parameter to proceed'
          end

          DateTime.parse(schedule_params[:to_date])
        end

        def schedule_params
          params.require(:schedule).permit(:from_date, :to_date)
        end
      end
    end
  end
end
