#!/bin/python3

import subprocess 
import re
count=0
apps=1
def rmpkg(a):
    return re.sub('^package:','',a)

def adbpull(a):
    subprocess.run(['adb','pull',a]) 
    count=count+1
    print('progress='+count+'/'+apps)
    return

pack=list(map( rmpkg, subprocess.run(['adb','shell','pm','list','packages','-3'],capture_output=True,encoding='UTF-8').stdout.splitlines()))
packagenames=list(map(lambda a: subprocess.run(['adb','shell','pm','path',a],capture_output=True ,encoding='UTF-8').stdout,pack))
pkgpaths=list(map(lambda a : re.sub('\n$','',str(a)) ,list(map(rmpkg ,packagenames))))
apps=len(pkgpaths)
#list(map(adbpull ,pkgpaths))
#list(map(lambda a : subprocess.run(['adb','pull',a]) ,pkgpaths) ) 
for i in pkgpaths:
    subprocess.run(['adb','pull',i,str(pack[count])+'.apk']) 
    count=count+1
    print('progress='+str(count)+'/'+str(apps))
    


