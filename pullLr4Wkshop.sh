#!/bin/bash

# This script pulls down the files under "Service->Workshop Information",
# which is most of the factory workshop manual.
# Replace 175405.html as needed with your index file if it differs
# Replace the wget commands (there are two) per the README.
# Output will be stored with the local subdirectory as the top of the recursive
# wget.

found=0
relFound=0
titleFound=0
title=""
for indexString in `cat 175405.html`
do
    if [ $found == 0 ]
    then
        leafString=`echo $indexString|grep leafNode`
        if [ "$leafString" != "" ]
        then
            found=1
        fi
    elif [ $relFound == 0 ]
    then
        relPt1=`echo $indexString|cut -d# -f 1|cut -d\" -f 2`
        relPt2=`echo $indexString|cut -d# -f 2|cut -d\" -f 1`
        relFound=1
    elif [ $titleFound == 0 ]
    then
        titleString=`echo $indexString|grep "title="`
        if [ "$titleString" != "" ]
        then
            title=`echo $indexString|cut -d\> -f 2|cut -d\< -f 1`
            titleFound=1
            isEndString=`echo $indexString|grep \<`
            if [ "$isEndString" != "" ]
            then
                echo "************" "$relPt1"_"$relPt2"_"$title" "*************"
                title=""
                found=0
                relFound=0
                titleFound=0
                /home/michael/wget/bin/wget -r --no-check-certificate --page-requisites -k -t 20 -T 15 --header='Host: topix.landrover.jlrext.com' --header='User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:15.0) Gecko/20100101 Firefox/15.0.1' --header='Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' --header='Accept-Language: en-us,en;q=0.5' --header='Accept-Encoding: ' --header='DNT: 1' --header='Connection: keep-alive' --header='Referer: https://topix.landrover.jlrext.com/topix/service/document/175405' --header='Cookie: LOCALE=en_GB; COUNTRY=US; JSESSIONID=85B4A5DBC70160D2D1DBF457E032D58D.prs72905' 'https://topix.landrover.jlrext.com/topix/service/procedure/175405/ODYSSEY/'$relPt1'/en_US?uid='$relPt2'' --content-disposition -c
            fi
        fi
    else
        isEndString=`echo $indexString|grep \<`
        if [ "$isEndString" == "" ]
        then
            title=$title$indexString
        else
            title=$title`echo $indexString|cut -d\< -f 1`
            echo "**************" "$relPt1"_"$relPt2"_"$title" "****************"
            title=""
            found=0
            relFound=0
            titleFound=0
            /home/michael/wget/bin/wget -r --no-check-certificate --page-requisites -k -t 20 -T 15 --header='Host: topix.landrover.jlrext.com' --header='User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:15.0) Gecko/20100101 Firefox/15.0.1' --header='Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' --header='Accept-Language: en-us,en;q=0.5' --header='Accept-Encoding: ' --header='DNT: 1' --header='Connection: keep-alive' --header='Referer: https://topix.landrover.jlrext.com/topix/service/document/175405' --header='Cookie: LOCALE=en_GB; COUNTRY=US; JSESSIONID=85B4A5DBC70160D2D1DBF457E032D58D.prs72905' 'https://topix.landrover.jlrext.com/topix/service/procedure/175405/ODYSSEY/'$relPt1'/en_US?uid='$relPt2'' --content-disposition -c
        fi
    fi
done

# Test command
#  /home/michael/bin/wget/wget -r --no-check-certificate --page-requisites -k -t 20 -T 15 --header='Host: topix.landrover.jlrext.com' --header='User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:15.0) Gecko/20100101 Firefox/15.0.1' --header='Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' --header='Accept-Language: en-us,en;q=0.5' --header='Accept-Encoding: ' --header='DNT: 1' --header='Connection: keep-alive' --header='Referer: https://topix.landrover.jlrext.com/topix/service/document/175405' --header='Cookie: LOCALE=en_GB; COUNTRY=US; JSESSIONID=85B4A5DBC70160D2D1DBF457E032D58D.prs72905' 'https://topix.landrover.jlrext.com/topix/service/procedure/175405/ODYSSEY/G941389/en_US?uid=G1379963' --content-disposition -c
