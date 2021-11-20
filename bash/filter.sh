 #!/bin/bash

grep -i Power apcupsd.events |\
	sed 's/ Power f.*/S/g; s/ P.*/E/g' |\
(	while read line # loeb read, 1 rida kaupa, line on muutuja milesse loetakse praegune rida
	do
	  D=$( date -d "${line:0:26}" +"%s")
	  EV=${line:26}
	  echo $EV" "$D # format like *E 1582592877*
	done
) | awk -f deltacalk.awk | tee vahetulemused.txt
./sec_filter.sh

