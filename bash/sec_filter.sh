#!/bin/bash
cat vahetulemused.txt | while read -r line; do
        step=300
        start=$(echo $rida | cut -d ":" -f1)
        value=$(echo $rida | cut -d ":" -f2)
        stop=$(echo $line | cut -d ":" -f1)
        if [[ -n "$start" && -n "$stop" && -n "$value" && -n "$rida" ]]; then
                if [[ $start > 0 && $stop > 0 && $stop > $start ]]; then
                        ./F.sh $start $stop $step $value
                fi
        fi
        rida=$line
done | tee output.txt

