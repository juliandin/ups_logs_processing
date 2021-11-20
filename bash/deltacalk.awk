BEGIN{
	OF="vahetulemused.txt"
}
/[S]/ {
	if( start > 0 ) {
		print start ":2" > OF
	}
	start=$2
	end=0
}
/[E]/ {
	if( end > 0 ) {
#		print "Err: topelt End"
	}
	end=$2
	print start ":" end-start > OF
	start=0
}
