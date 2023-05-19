#!/bin/bash 
mapfile -t packages < <(adb shell pm list packages -3  | cut -d : -f 2 )
mapfile -t packages2 < <(adb shell pm list packages | cut -d : -f 2 | grep google  )
pkgcount=${#packages[@]}
count=0
for pkg in "${packages[@]}";
do
		apkpath="$(adb shell pm path "$pkg" |cut -d : -f 2  )"
		if [[ ! -f "$pkg.apk" ]]  
		then
				if adb pull "$apkpath" "$pkg.apk"
				then
						(( count++ ))
						 echo "----(""$count""/""$pkgcount"")----"
		else 
				  echo "--skipping ""$pkg""--already exists----"
		fi
		fi 
done

pkgcount2=${#packages2[@]}

(( pkgcount = pkgcount + pkgcount2  ))
for pkg in "${packages2[@]}";
do
		if [[ "$1" = "google" ]]
		then
				echo "getting google apps "
				apkpath="$(adb shell pm path "$pkg" |cut -d : -f 2  )"
				if [[ ! -f "$pkg.apk" ]]
				then
						if adb pull "$apkpath" "$pkg.apk"
						then
								(( count++ ))
								 echo "----(""$count""/""$pkgcount2"")----"
						fi 
				else 

				  echo "--skipping ""$pkg""--already exists----"
				fi 
		fi 
done
