#!/bin/bash
#
# DLTM 1.0 copyright marcin@hexdump.pl
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#

time=$(date +"%Y-%m-%d_%H:%M:%S")

URL1="http://speedtest.wdc01.softlayer.com/downloads/test10.zip"
URL2="http://download.thinkbroadband.com/20MB.zip"
URL3="http://test.mm.pl/100.tmp"


function test()
{
    URL=$1
    TEST=`curl -s -w "%{speed_download}" $URL -o /path/to/test.dl`
    RESULT=`echo "scale=2; ${TEST%%,*} / 131072" | bc | xargs -I {} echo {} Mb\/s`
}

test $URL1
echo 10MB: $RESULT > /path/to/speed
A=$RESULT

test $URL2
echo 20MB: $RESULT >> /path/to/speed
B=$RESULT

test $URL3
echo 100MB: $RESULT >> /path/to/speed
C=$RESULT

AVERAGE=`echo "scale=2;(${A%% *}+${B%% *}+${C%% *})/3" | bc | xargs -I {} echo {} Mb\/s`

echo "Srednia: $AVERAGE" >> /path/to/speed

mv /home/m/tools/multimedia/speed /path/to/netspeed/speed_"$time" #must create "netspeed" directory RW
rm /path/to/test.dl
