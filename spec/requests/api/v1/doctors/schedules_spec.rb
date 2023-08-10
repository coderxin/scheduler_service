# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/doctors/:doctor_id/schedule', type: :request do
  describe 'GET /index' do
    context 'when invalid query parameters are given' do
      it do
        doctor = create(:doctor)

        get api_v1_doctor_schedule_url(doctor.id), as: :json

        expect(response).to be_bad_request
        expect(JSON.parse(response.body)).to eq({ 'error' => 'param is missing or the value is empty: schedule' })
      end

      it do
        doctor = create(:doctor)

        get api_v1_doctor_schedule_url(doctor.id, schedule: { wrong: :wrong }), as: :json

        expect(response).to be_bad_request
        expect(JSON.parse(response.body)).to eq(
          { 'error' => 'Please provide schedule[from_date] parameter to proceed' }
        )
      end

      it do
        doctor = create(:doctor)

        get api_v1_doctor_schedule_url(doctor.id, schedule: { from_date: '2021-01-04' }), as: :json

        expect(response).to be_bad_request
        expect(JSON.parse(response.body)).to eq({ 'error' => 'Please provide schedule[to_date] parameter to proceed' })
      end
    end

    context 'when valid query parameters are given' do
      it do
        doctor = create(:doctor, :with_config)

        scheduler = instance_double(Scheduler, call: [{ '2021-01-04' => 'test' }])
        allow(Scheduler).to receive(:new).with(
          doctor:,
          start_date: DateTime.parse('2021-01-04'),
          end_date: DateTime.parse('2021-01-05')
        ).and_return(scheduler)

        schedule_decorator = instance_double(ScheduleDecorator, as_json: 'decorated response')
        allow(ScheduleDecorator).to receive(:new).with([{ '2021-01-04' => 'test' }]).and_return(schedule_decorator)

        get api_v1_doctor_schedule_url(
          doctor.id, schedule: { from_date: '2021-01-04', to_date: '2021-01-05' }
        ), as: :json

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to eq({ 'data' => 'decorated response' })
      end
    end
  end
end
