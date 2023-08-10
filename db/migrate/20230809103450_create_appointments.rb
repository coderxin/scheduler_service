# frozen_string_literal: true

class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.belongs_to :doctor

      t.datetime :start_at, null: false
      t.datetime :end_at, null: false

      t.timestamps
    end

    add_index :appointments, [:doctor_id, :start_at], unique: true
    add_index :appointments, [:start_at, :end_at]
  end
end
