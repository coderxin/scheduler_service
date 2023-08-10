# README

This repository contains solution for the https://github.com/huerlisi/engineering-excercise problem.

Outcome: JSON API to return free time slots for dentist appointment booking.

## How to setup

### Using Docker

To build image and start docker-compose, please run (it will make application available under `localhost:3000`):
```sh
sh start.sh
```

To stop Docker containers:
```sh
sh stop.sh
```

To perform cleanup (stop containers and prune the system):
```sh
sh stop.sh
```

### Local setup

For the local setup implementation does require:
- Ruby `3.2.2`
- MySQL `8.0.33`

For example, using RVM:

```bash
rvm install ruby-3.2.2
rvm use ruby-3.2.2@scheduler_service --create
gem install bundler:2.4
bundle install
```

Setup of the database:
```bash
rake db:create db:migrate db:seed
```

Run the server:
```bash
bin/rails s
```

Rspec Specs:
```bash
bundle exec rspec 
```

Linter:
```bash
bundle exec rubocop 
```

## API documentation

For convenience please use [Postman collection](https://github.com/coderxin/scheduler_service/blob/main/docs/Denteo%20Engineering%20Excercise.postman_collection.json).

```                                                              
GET    /api/v1/doctors                                                                   
GET    /api/v1/doctors/:doctor_id/schedule                                                               
GET    /api/v1/doctors/:doctor_id/appointments                                                 
```

Get all available doctors:

```curl
curl --request GET 'localhost:3000/api/v1/doctors'
```

Get free timeslots for a given time range:

```curl
curl --request GET 'localhost:3000/api/v1/doctors/2/schedule' \
     --form 'schedule[from_date]="2021-01-04"' \
     --form 'schedule[to_date]="2021-01-07"'
```

Get all appointments of particular doctor:

```curl
curl --request GET 'localhost:3000/api/v1/doctors'
```

## Potential further improvements

- add more specs
- configure cors
- introduce authentication for patients
- add validation logic for the models (for example appointment creation and conflict management with available slots or appointments)
- add related patient functionality
- add functionality to manage appointments
- add pagination (for example using kaminari) for response time optimisation
- add swagger API documentation (for example using swagger-blocks gem)
- add Github actions to run specs, rubocop and deploy to staging and production server
- move TimeSlot and TimeSlotCollection from app/services folder
- add namespacing for Scheduler and related objects (TimeSlot, TimeSlotCollection)
