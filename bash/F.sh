#!/bin/bash

start=$1
stop=$2
step=$3
value=$4

if [[ ${#@} -ne 4 ]]; then
	echo "Usage: $0 <start> <stop> <step> <value>";
	exit 1
fi

if [[ ${step} > 0 && ${start} > 0 && $((${stop} - 1)) > ${start} ]] ; then
	z=$(( ${start} + ${value} ))
	if [[ ${start} != ${z} ]]; then
		seq -f "%1.f:$value" ${start} ${step} ${z}
	fi
	seq -f "%1.f:0" $((${z})) ${step} $(($stop - 1))
fi
