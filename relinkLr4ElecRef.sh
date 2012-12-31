#!/bin/bash

# This script modifies the index file so the files downloaded can be read
# locally with a web browser.
# Rename lr4toc.htm as needed.  Rename output file if desired.
# Files are referenced relatively, so this should work at any location.

for indexString in `cat lr4toc.htm`
do
    refString=`echo $indexString|grep href=\"`
    if [ "$refString" != "" ]
    then
        fileName=`echo $indexString|cut -d\" -f 2|cut -d# -f 1`
        repString=`echo $indexString|cut -d\" -f 2`
        echo $indexString | sed s/"$repString"/"topix.landrover.jlrext.com\/topix\/service\/archive\/227777\/"$fileName/ >> lr4tocnew.htm
    else
        echo $indexString >> lr4tocnew.htm
    fi
done
