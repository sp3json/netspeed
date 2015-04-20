#!/bin/bash
time=$(date +"%Y-%m-%d_%H:%M:%S")

URL1="http://speedtest.wdc01.softlayer.com/downloads/test10.zip"
URL2="http://download.thinkbroadband.com/20MB.zip"
URL3="http://test.mm.pl/100.tmp"


function test()
{
	URL=$1
	TEST=`curl -s -w "%{speed_download}" $URL -o /home/m/tools/multimedia/test`
	RESULT=`echo "scale=2; ${TEST%%,*} / 131072" | bc | xargs -I {} echo {} Mb\/s`
}

test $URL1
echo 10MB: $RESULT > /home/m/tools/multimedia/speed
A=$RESULT

test $URL2
echo 20MB: $RESULT >> /home/m/tools/multimedia/speed
B=$RESULT

test $URL3
echo 100MB: $RESULT >> /home/m/tools/multimedia/speed
C=$RESULT

AVERAGE=`echo "scale=2;(${A%% *}+${B%% *}+${C%% *})/3" | bc | xargs -I {} echo {} Mb\/s`

echo "Srednia: $AVERAGE" >> /home/m/tools/multimedia/speed

mv /home/m/tools/multimedia/speed /home/m/tools/multimedia/netspeed/speed_"$time"
rm /home/m/tools/multimedia/test