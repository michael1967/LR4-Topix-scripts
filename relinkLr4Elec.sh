#!/bin/bash

# This script modifies the index file so the files downloaded can be read
# locally with a web browser.
# Rename 202262.htm as needed.  Rename output file if desired.
# Files are referenced relatively, so this should work at any location.

found=0
titleFound=0
for indexString in `cat 202262.htm`
do
    if [ $found == 0 ]
    then
        relString=`echo $indexString|grep rel=\"`
        if [ "$relString" != "" ]
        then
            found=1
        fi
        echo $indexString >> 202262new.htm
    elif [ $titleFound == 0 ]
    then
        titleString=`echo $indexString|grep \<nobr\>`
        if [ "$titleString" != "" ]
        then
            hrefString=$indexString
            title=`echo $indexString|cut -d\> -f 3|cut -d\< -f 1`
            titleLinkName=$title
            titleFirstWord=$title
            titleFound=1
            isEndString=`echo $indexString|grep \</nobr\>`
            if [ "$isEndString" != "" ]
            then
                echo $indexString | sed s/#/$title.pdf/>>202262new.htm
                title=""
                found=0
                titleFound=0
            fi
        else
            echo $indexString >> 202262new.htm
        fi
    else
        isEndString=`echo $indexString|grep \</nobr\>`
        if [ "$isEndString" == "" ]
        then
            title=$title$indexString
            titleLinkName=`echo $titleLinkName $indexString`
        else
            titleLastWord=`echo $indexString|cut -d\< -f 1`
            title=$title$titleLastWord
            echo $hrefString | sed s/$titleFirstWord/"$titleLinkName"/ | sed s/"#"/$title.pdf/ >> 202262new.htm
            echo $indexString >> 202262new.htm
            title=""
            found=0
            titleFound=0
        fi
    fi
done
