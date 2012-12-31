#!/bin/bash

# This script modifies the index file so the files downloaded can be read locally with a web browser.
# Rename 175405.html as needed.  Rename output file if desired.
# Files are referenced relatively, so this should work at any location.

found=0
relFound=0
hrefFound=0
for indexString in `cat 175405.html`
do
    if [ $found == 0 ]
    then
        leafString=`echo $indexString|grep leafNode`
        if [ "$leafString" != "" ]
        then
            found=1
        fi
        echo $indexString >> 175405new.html
    elif [ $relFound == 0 ]
    then
        relPt1=`echo $indexString|cut -d# -f 1|cut -d\" -f 2`
        relPt2=`echo $indexString|cut -d# -f 2|cut -d\" -f 1`
        relFound=1
        mv topix.landrover.jlrext.com/topix/service/procedure/175405/ODYSSEY/$relPt1/en_US?uid=$relPt2 topix.landrover.jlrext.com/topix/service/procedure/175405/ODYSSEY/$relPt1/foo.html
        echo $indexString >> 175405new.html
    else
        echo href="topix.landrover.jlrext.com/topix/service/procedure/175405/ODYSSEY/"$relPt1"/foo.html" >> 175405new.html
        found=0
        relFound=0
    fi
done
