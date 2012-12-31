LR4-Topix-scripts
=================

Scripts to download manuals from the Land Rover Topix manual site
-----------------------------------------------------------------
These scripts pull down various manual pages from the Land Rover Topix manual site.  I've only run this on Linux but it should also work with Cygwin.  You'll need two tools to run these scripts:

- wget.  I had to patch & rebuild my wget to get around all of the SSL failures I was seeing.  The patches are available at http://savannah.gnu.org/bugs/?20523.  I used both patches.

- Firefox add-on cliget.

The scripts require hand editing.  First, each script references an index HTML file that is parsed.  For example, the script "pullLr4Wkshop.sh" references 175405.html.  This file contains a list of sections to be pulled down by the script and is typically one frame of a page.  The easiest way to get this index file is with Firefox by right-clicking on the frame with the list of entries of interest (making sure you're not selecting a link within the frame) and select "This Frame --> Save Frame As...".

Second, most of the wget command within the script is uinque to your PC & browser.  wget uses the cookies, etc... from your topix session to pull down the files.  However, this command is also highly dependent up on script variables and the wget location - as I said, I had to use a rebuilt wget and I rebuilt in my home directory.  To get the "meat" of the script, within the frame right click on one of the links within the frame discussed in the previous paragraph and select "Copy wget For Link".  Paste this into a scratchpad somewhere.  The output will look something like this:

wget --header='Host: topix.landrover.jlrext.com' --header='User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:15.0) Gecko/20100101 Firefox/15.0.1' --header='Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' --header='Accept-Language: en-us,en;q=0.5' --header='Accept-Encoding: gzip, deflate' --header='DNT: 1' --header='Connection: keep-alive' --header='Referer: https://topix.landrover.jlrext.com/topix/service/document/175405' --header='Cookie: LOCALE=en_GB; COUNTRY=US; JSESSIONID=85B4A5DBC70160D2D1DBF457E032D58D.prs72905' 'https://topix.landrover.jlrext.com/topix/service/procedure/175405/ODYSSEY/G941389/en_US?uid=G1379963' --content-disposition -c

You need to make a few changes:

 /home/michael/wget/bin/wget -r --no-check-certificate --page-requisites -k -t 20 -T 15 --header='Host: topix.landrover.jlrext.com' --header='User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:15.0) Gecko/20100101 Firefox/15.0.1' --header='Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' --header='Accept-Language: en-us,en;q=0.5' --header='Accept-Encoding: ' --header='DNT: 1' --header='Connection: keep-alive' --header='Referer: https://topix.landrover.jlrext.com/topix/service/document/175405' --header='Cookie: LOCALE=en_GB; COUNTRY=US; JSESSIONID=85B4A5DBC70160D2D1DBF457E032D58D.prs72905' 'https://topix.landrover.jlrext.com/topix/service/procedure/175405/ODYSSEY/'$relPt1'/en_US?uid='$relPt2' --content-disposition -c
 
 o Use the rebuilt version of wget (unless you're not running into HTTPS problems).
 
 o Add -r to make it recursive to pull in files referenced by the web page.  Otherwise you don't get images.
 
 o Add --no-check-certificate  because the certificate from the LR web site does not match the web site name.
 
 o Add --page-requesites for reasons similar to -r.
 
 o Add -k to convert links within the web page so they reference local files.
 
 o Add -t for the number of retries.
 
 o Add -T for the time-out.  If you start seeing HTTPS failures, you'll need the wget patch mentioned above.
 
 o Remove the "gzip, deflate" option from the "Accept-Encoding" header, as this busts the recursive & page requisite options.
 
 o Replace G941389 with the variable $relPt1 pulled from 175405.html.
 
 o Replace G1379963 with the variable $relPt2 pulled from 175405.html. 

Also please pay attention to any notes I've placed in the scripts.  At least one script required minor editing of the index HTML.

Scripts to edit the index from the Land Rover Topix manual site
---------------------------------------------------------------
I also created some scripts to modify the index files to work on a local hard drive.  As with the download scripts you'll likley need to modify the name of the index file.  You should use the same index file downloaded when the files were downloaded..  These scripts preserve the old file and create a new file.  Once these scripts run you should be open the index with your web browser and browse the files locally as if you were on the LR Topix web site.  Note that the output of my script is not nearly as nice as the LR Topix web site but it is functional.
