#!/bin/bash

cd /opt/scripts

TOTAL=`ls . | wc -l`

#chmod +x -R /opt/scripts

for i in `ls . | grep -v "build.sh" | grep -v "server.sh"` ;do
	 ./$i
	 echo $i
done

#i=1

#while [ $i -le $(($TOTAL - 1)) ]; do
#	i=$(( $i + 1 ))
#	echo "$i - $TOTAL"
#done


