#!/bin/bash

# This script pulls down the files under "Service->Electrical Information->
# Elecrical Wiring Diagrams".
# Replace 202262.htm as needed with your index file if it differs
# Replace the wget commands (there are two) per the README.
# Output will be stored within the local subdirectory as a collection of PDFs.
# Note the difference in the wget command from the other scripts.  There is no recursiveness and
# there is a single output file.

found=0
titleFound=0
title=""
for indexString in `cat 202262.htm`
do
    if [ $found == 0 ]
    then
        relString=`echo $indexString|grep rel=\"`
        if [ "$relString" != "" ]
        then
            found=1
            relString=`echo $indexString|cut -d\" -f 2|cut -d# -f 1`
        fi
    elif [ $titleFound == 0 ]
    then
        titleString=`echo $indexString|grep \<nobr\>`
        if [ "$titleString" != "" ]
        then
            title=`echo $indexString|cut -d\> -f 3|cut -d\< -f 1`
            titleFound=1
            isEndString=`echo $indexString|grep \</nobr\>`
            if [ "$isEndString" != "" ]
            then
                echo "***************" "$relString"_"$title" "********************"
                /home/michael/wget/bin/wget --no-check-certificate -t 20 -T 15 --header='Host: topix.landrover.jlrext.com' --header='User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:15.0) Gecko/20100101 Firefox/15.0.1' --header='Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' --header='Accept-Language: en-us,en;q=0.5' --header='Accept-Encoding: gzip, deflate' --header='DNT: 1' --header='Connection: keep-alive' --header='Referer: https://topix.landrover.jlrext.com/topix/service/document/202262' --header='Cookie: LOCALE=en_GB; COUNTRY=US; JSESSIONID=85B4A5DBC70160D2D1DBF457E032D58D.prs72905' 'https://topix.landrover.jlrext.com/topix/service/procedure/202262/PDF/'$relString'/en_GB?uid='$relString'&time=1356581713085#pagemode=none&toolbar=1&statusbar=0&messages=0&navpanes=1&view=FitH&page=1' -O $title -c
                title=""
                found=0
                titleFound=0
            fi
        fi
    else
        isEndString=`echo $indexString|grep \</nobr\>`
        if [ "$isEndString" == "" ]
        then
            title=$title$indexString
        else
            title=$title`echo $indexString|cut -d\< -f 1`
            echo "***************" "$relString"_"$title" "********************"
            /home/michael/wget/bin/wget --no-check-certificate -t 20 -T 15 --header='Host: topix.landrover.jlrext.com' --header='User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:15.0) Gecko/20100101 Firefox/15.0.1' --header='Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' --header='Accept-Language: en-us,en;q=0.5' --header='Accept-Encoding: gzip, deflate' --header='DNT: 1' --header='Connection: keep-alive' --header='Referer: https://topix.landrover.jlrext.com/topix/service/document/202262' --header='Cookie: LOCALE=en_GB; COUNTRY=US; JSESSIONID=85B4A5DBC70160D2D1DBF457E032D58D.prs72905' 'https://topix.landrover.jlrext.com/topix/service/procedure/202262/PDF/'$relString'/en_GB?uid='$relString'&time=1356581713085#pagemode=none&toolbar=1&statusbar=0&messages=0&navpanes=1&view=FitH&page=1' -O $title -c
            title=""
            found=0
            titleFound=0
        fi
    fi
done

# Test Command
# /home/michael/wget/bin/wget --no-check-certificate -t 20 -T 15 --header='Host: topix.landrover.jlrext.com' --header='User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:15.0) Gecko/20100101 Firefox/15.0.1' --header='Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' --header='Accept-Language: en-us,en;q=0.5' --header='Accept-Encoding: gzip, deflate' --header='DNT: 1' --header='Connection: keep-alive' --header='Referer: https://topix.landrover.jlrext.com/topix/service/document/202262' --header='Cookie: LOCALE=en_GB; COUNTRY=US; JSESSIONID=85B4A5DBC70160D2D1DBF457E032D58D.prs72905' 'https://topix.landrover.jlrext.com/topix/service/procedure/202262/PDF/09851d0b-b001-4abe-8b99-dfdcbc73074e/en_GB?uid=09851d0b-b001-4abe-8b99-dfdcbc73074e&time=1356581713085#pagemode=none&toolbar=1&statusbar=0&messages=0&navpanes=1&view=FitH&page=1' -O 'en_GB' -c
