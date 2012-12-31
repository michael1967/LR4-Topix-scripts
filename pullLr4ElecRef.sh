#!/bin/bash

# This script pulls down the files under "Service->Electrical Information->
# Elecrical Reference".  This shows the location and pin-outs of electrical
# connectors (very handy).
# Replace lr4toc.htm as needed with your index file if it differs
# Replace the wget command per the README.
# Output will be stored with the local subdirectory as the top of the recursive
# wget.

found=0
titleFound=0
title=""
for indexString in `cat lr4toc.htm`
do
    refString=`echo $indexString|grep href=\"`
    if [ "$refString" != "" ]
    then
        refString=`echo $indexString|cut -d\" -f 2`
        /home/michael/wget/bin/wget -r --no-check-certificate --page-requisites -k -t 20 -T 15 --header='Host: topix.landrover.jlrext.com' --header='User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:15.0) Gecko/20100101 Firefox/15.0.1' --header='Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' --header='Accept-Language: en-us,en;q=0.5' --header='Accept-Encoding: ' --header='DNT: 1' --header='Connection: keep-alive' --header='Referer: https://topix.landrover.jlrext.com/topix/content/document/view?groupId=252&id=227777' --header='Cookie: LOCALE=en_GB; COUNTRY=US; JSESSIONID=85B4A5DBC70160D2D1DBF457E032D58D.prs72905' 'https://topix.landrover.jlrext.com/topix/service/archive/227777/'$refString --content-disposition -c
    fi
done

# Test command
# /home/michael/wget/bin/wget -r --no-check-certificate --page-requisites -k -t 20 -T 15 --header='Host: topix.landrover.jlrext.com' --header='User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:15.0) Gecko/20100101 Firefox/15.0.1' --header='Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' --header='Accept-Language: en-us,en;q=0.5' --header='Accept-Encoding: gzip, deflate' --header='DNT: 1' --header='Connection: keep-alive' --header='Referer: https://topix.landrover.jlrext.com/topix/content/document/view?groupId=252&id=227777' --header='Cookie: LOCALE=en_GB; COUNTRY=US; JSESSIONID=85B4A5DBC70160D2D1DBF457E032D58D.prs72905' 'https://topix.landrover.jlrext.com/topix/service/archive/227777/1_C0004.htm#1_C0004' --content-disposition -c
