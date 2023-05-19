#!/bin/bash 
if ! adb devices 
then
		echo " nno device "
exit 1
fi 

packages="$( adb shell pm list packages -3  | cut -d : -f 2  )"
pkgcount="$( echo "$packages" |wc -l  )"
count=0
while IFS= read -r line ;
do 
		 #echo " tis is ""$line"""
		apkpath="$(adb shell pm path "$line.apk" | cut -d : -f 2  )"
		if adb pull "$apkpath" "$line"
		then
				(( count++ ))
				 echo "----(""$count""/""$pkgcount"")----"

		fi
done < <( echo "$packages" )
