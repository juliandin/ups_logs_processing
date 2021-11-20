#!/bin/bash

rrdtool graph Powerfails_2y.png \
        --end now --start end-2y-30d \
        -h 768 -w 1024 \
        -a PNG -t "Powerfails in 2 years" \
	-o -r -l 1 \
        DEF:pwr=powerfails.rrd:powerfail:MAX \
        LINE1:pwr#C70C70:"Powerfails"
