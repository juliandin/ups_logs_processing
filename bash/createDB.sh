#!/bin/bash

#f_time=`head -1 output.txt | cut -d ":" -f 1`
#begin=$(( ${f_time} - 1 ))

rrdtool create powerfails.rrd \
                --step 300s \
                --start now-2Y-20d \
                DS:powerfail:GAUGE:10m:0:U \
                RRA:MAX:0.5:5m:30d \
                RRA:MAX:0.5:10m:90d \
                RRA:MAX:0.5:1h:18M \
                RRA:MAX:0.5:1d:10y |\
cat output.txt | xargs rrdtool update powerfails.rrd
