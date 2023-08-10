# frozen_string_literal: true

doctor_paul = Doctor.create(first_name: 'Paul', last_name: 'Revere')
doctor_paul.create_doctor_config(
  day_start_time: '08:00',
  day_end_time: '18:00',
  blocker_start_time: '12:00',
  blocker_end_time: '13:00',
  time_slot_duration_in_seconds: 30 * 60 # 30 minutes
)

doctor_paul.appointments.create(
  start_at: DateTime.parse('2023-08-09 14:45:00 +0200'),
  end_at: DateTime.parse('2023-08-09 15:00:00 +0200')
)
doctor_paul.appointments.create(
  start_at: DateTime.parse('2023-08-09 15:30:00 +0200'),
  end_at: DateTime.parse('2023-08-09 16:00:00 +0200')
)
doctor_paul.appointments.create(
  start_at: DateTime.parse('2023-08-09 16:00:00 +0200'),
  end_at: DateTime.parse('2023-08-09 16:30:00 +0200')
)
doctor_paul.appointments.create(
  start_at: DateTime.parse('2023-08-09 16:30:00 +0200'),
  end_at: DateTime.parse('2023-08-09 18:00:00 +0200')
)

# Dataset provided in https://github.com/huerlisi/engineering-excercise

doctor_bill = Doctor.create(first_name: 'Bill', last_name: 'Dorfman')
doctor_bill.create_doctor_config(
  day_start_time: '08:00',
  day_end_time: '18:00',
  blocker_start_time: '12:00',
  blocker_end_time: '13:00',
  time_slot_duration_in_seconds: 30 * 60 # 30 minutes
)

doctor_bill.appointments.create(
  start_at: DateTime.parse('2021-01-04 10:15:00 +0100'),
  end_at: DateTime.parse('2021-01-04 10:30:00 +0100')
)
doctor_bill.appointments.create(
  start_at: DateTime.parse('2021-01-05 11:00:00 +0100'),
  end_at: DateTime.parse('2021-01-05 11:30:00 +0100')
)
doctor_bill.appointments.create(
  start_at: DateTime.parse('2021-01-05 15:30:00 +0100'),
  end_at: DateTime.parse('2021-01-05 16:30:00 +0100')
)
doctor_bill.appointments.create(
  start_at: DateTime.parse('2021-01-06 10:00:00 +0100'),
  end_at: DateTime.parse('2021-01-06 10:30:00 +0100')
)
doctor_bill.appointments.create(
  start_at: DateTime.parse('2021-01-06 11:00:00 +0100'),
  end_at: DateTime.parse('2021-01-06 12:30:00 +0100')
)
doctor_bill.appointments.create(
  start_at: DateTime.parse('2021-01-06 17:30:00 +0100'),
  end_at: DateTime.parse('2021-01-06 18:00:00 +0100')
)

doctor_pierre = Doctor.create(first_name: 'Pierre', last_name: 'Fauchard')
doctor_pierre.create_doctor_config(
  day_start_time: '09:00',
  day_end_time: '17:00',
  blocker_start_time: '14:00',
  blocker_end_time: '15:00',
  time_slot_duration_in_seconds: 60 * 60 # 60 minutes
)
