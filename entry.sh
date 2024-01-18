#!/bin/sh

# start cron
#/usr/sbin/crond -f -l 8

while :
do
	DATE=`date`
	mkdir -p /tmp/xmltv/raws
	mkdir -p /tmp/xmltv/sorted

	echo "Run zap2xml.pl"
	/zap2xml.pl -u $USERNAME -p $PASSWORD -U -o /tmp/xmltv/raws/1.xml -c cache1 $OPT_ARGS

	if [ $USERNAME2 = "none" ]
	then
		# Just move the raw file to the output
		mv /tmp/xmltv/raws/1.xml /data/$XMLTV_FILENAME
	else
		# Run it again, sort, and merge the files
		echo "Run zap2xml.pl for second user"
		/zap2xml.pl -u ${USERNAME2} -p ${PASSWORD2} -U -o /tmp/xmltv/raws/2.xml -c cache2 $OPT_ARGS2
		echo "Sorting both files"
		tv_sort /tmp/xmltv/raws/1.xml --by-channel --output /tmp/xmltv/sorted/1.xml
		tv_sort /tmp/xmltv/raws/2.xml --by-channel --output /tmp/xmltv/sorted/2.xml
		echo "Merging both files"
		tv_merge -i /tmp/xmltv/sorted/1.xml -m /tmp/xmltv/sorted/2.xml -o /data/$XMLTV_FILENAME
	fi
	echo "Removing intermediate files"
	rm -rf /tmp/xmltv
	echo "Last run time: $DATE"
	echo "Will run in $SLEEPTIME seconds"
	sleep $SLEEPTIME
done
