#!/bin/bash
# start_rails.sh

bundle exec rake db:migrate
bundle exec rails s -p 3000 -P /tmp/sense_api.pid -b '0.0.0.0'
