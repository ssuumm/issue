#!/bin/bash
# wait_for_mysql.sh

set -e

cmd="$@"
host="$SENSE_API_DATABASE_HOST"
user="$SENSE_API_DATABASE_USERNAME"
export MYSQL_PWD="$SENSE_API_DATABASE_PASSWORD"

until mysql -u$user -h$host -e 'SELECT 1' &> /dev/null; do
  >&2 echo "MySQL is unavailable - sleeping"
  sleep 1
done

[ -f /tmp/sense_api.pid ] && rm /tmp/sense_api.pid || echo "Not found"
>&2 echo "MySQL is up - executing command"
exec $cmd
