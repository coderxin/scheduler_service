# frozen_string_literal: true

class CreateDoctorConfigs < ActiveRecord::Migration[7.0]
  def change
    create_table :doctor_configs do |t|
      t.belongs_to :doctor

      t.string :day_start_time, null: false
      t.string :day_end_time, null: false

      t.string :blocker_start_time, null: false
      t.string :blocker_end_time, null: false

      t.integer :time_slot_duration_in_seconds, null: false

      t.timestamps
    end
  end
end
