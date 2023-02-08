#!/bin/sh

# start cron
#/usr/sbin/crond -f -l 8

while :
do
  DATE=`date`
  LASTRUN=$('date' +%s)
  /zap2xml.pl -u $USERNAME -p $PASSWORD -U -o /data/$XMLTV_FILENAME $OPT_ARGS
  LASTXMLMOD=$(date -r ./data/$XMLTV_FILENAME +%s)
  if test $LASTXMLMOD -gt $LASTRUN
  then
      echo "Last run time: $DATE"
      echo "Will run in $SLEEPTIME seconds"
      sleep $SLEEPTIME
  else
      echo "Last run time: $DATE"
      echo "Did not complete successfully"
      echo "Pausing for 30 seconds and trying again"
      sleep 30
  fi
done
