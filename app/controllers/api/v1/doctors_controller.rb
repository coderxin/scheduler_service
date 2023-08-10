# frozen_string_literal: true

module Api
  module V1
    class DoctorsController < ApplicationController
      def index
        render json: { data: [Doctor.all] }
      end
    end
  end
end
