# frozen_string_literal: true

Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :doctors, only: :index do
        scope module: 'doctors' do
          resource :schedule, only: :show
          resources :appointments, only: :index
        end
      end
    end
  end
end
