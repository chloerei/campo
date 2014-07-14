#!/bin/bash

### BEGIN INIT INFO
# Provides:          Campo
# Required-Start:    $all
# Required-Stop:     $network $local_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start the Campo resque worker at boot
# Description:       Enable Campo at boot time.
### END INIT INFO

set -e
set -u

APP_ROOT=/var/www/campo/current
USER=deploy

TIMEOUT=${TIMEOUT-60}
PIDFILE="$APP_ROOT/tmp/pids/resque.%d.pid"
QUEUES="*"
COUNT=1

run () {
  if [ "$(id -un)" = "$USER" ]; then
    eval $1
  else
    su -c "$1" - $USER
  fi
}

case "$1" in
  start)
    for i in $(seq 1 $COUNT); do
      pidfile=$(printf "$PIDFILE" $i)

      if test -s "$pidfile" && run "kill -0 `cat $pidfile`"; then
        echo "Worker `cat $pidfile` alread running"
      else
        run "cd $APP_ROOT; bundle exec rake environment resque:work QUEUE=$QUEUES PIDFILE=$pidfile TERM_CHILD=1 BACKGROUND=yes RAILS_ENV=production > /dev/null 2>&1"
        echo "Start worker `cat $pidfile`"
      fi
    done
    ;;
  stop)
    for i in $(seq 1 $COUNT); do
      pidfile=$(printf "$PIDFILE" $i)

      if test -s "$pidfile" && run "kill -QUIT `cat $pidfile`"; then
        echo "Stop worker `cat $pidfile`"
        run "rm $pidfile"
      fi
    done
    ;;
  restart|reload)
    $0 stop
    $0 start
    ;;
  *)
    echo >&2 "Usage: $0 <start|stop|restart|reload>"
    exit 1
    ;;
esac
