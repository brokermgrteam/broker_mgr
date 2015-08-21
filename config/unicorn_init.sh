#!/bin/sh
### BEGIN INIT INFO
# Provides:          unicorn
# Required-Start:    $local_fs $remote_fs
# Required-Stop:     $local_fs $remote_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: unicorn initscript
# Description:       unicorn
### END INIT INFO
set -e
# Example init script, this can be used with nginx, too,
# since nginx and unicorn accept the same signals

# Feel free to change any of the following variables for your app:
TIMEOUT=${TIMEOUT-60}
APP_ROOT=/home/deployer/apps/broker_mgr/current
PID=$APP_ROOT/tmp/pids/unicorn.pid
ENVIRONMENT=production
PATH="/home/deployer/.rbenv/bin:/home/deployer/.rbenv/shims:$PATH"
CMD="bin/unicorn -E $ENVIRONMENT -D -c $APP_ROOT/config/unicorn.rb"

cd $APP_ROOT
if [ "deployer" != `whoami` ]; then
  CMD="sudo -u deployer -- env PATH=$PATH $CMD"
fi
echo $CMD

action="$1"
set -u

old_pid="$PID.oldbin"

cd $APP_ROOT || exit 1

sig () {
  test -s "$PID" && kill -$1 `cat $PID`
}

oldsig () {
  test -s $old_pid && kill -$1 `cat $old_pid`
}

workersig () {
  workerpid="$APP_ROOT/tmp/pids/unicorn.$2.pid"
  test -s "$workerpid" && kill -$1 `cat $workerpid`
}

case $action in
start)
  sig 0 && echo >&2 "Already running" && exit 0
  $CMD
  ;;
stop)
  sig QUIT && exit 0
  echo >&2 "Not running"
  ;;
force-stop)
  sig TERM && exit 0
  echo >&2 "Not running"
  ;;
restart|reload)
  sig HUP && echo reloaded OK && exit 0
  echo >&2 "Couldn't reload, starting '$CMD' instead"
  $CMD
  ;;
upgrade)
  if sig USR2 && sleep 20 && sig 0 && oldsig QUIT
  then
    n=$TIMEOUT
    while test -s $old_pid && test $n -ge 0
    do
      printf '.' && sleep 1 && n=$(( $n - 1 ))
    done
    echo

    if test $n -lt 0 && test -s $old_pid
    then
      echo >&2 "$old_pid still exists after $TIMEOUT seconds"
      exit 1
    fi
    # add this line to bring up another worker for the scheduler right after the upgrade is done:
    sig TTIN
    exit 0
  fi
  echo >&2 "Couldn't upgrade, starting '$CMD' instead"
  $CMD
  ;;
kill_worker)
  workersig QUIT $2 && exit 0
  echo >&2 "Worker not running"
  ;;

reopen-logs)
  sig USR1
  ;;
*)
  echo >&2 "Usage: $0 <start|stop|restart|upgrade|force-stop|reopen-logs>"
  exit 1
  ;;
esac
