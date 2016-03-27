#!/bin/bash
##########################################################################################################
# Script to convert a bunch of PDF's in a folder into a bunch concatenated JPG's of a given height
# requires Imagemagick (available on pip on OSX or apt-get on linux)
#
# Usage:
# ./imageScripts
# follow prompts
#
# 3 folders created in the original dataset location:
# /og_pdf:			original pdfs
# /small_jpgs:		pagewise jpgs
# /concat_jpg:		concatenated jpgs 
#
# Marko Stamenovic
# March 26, 2016
# University or Rochester
# GPL Open License
##########################################################################################################

echo "enter folder of PDF dataset for conversion:"
read folder
##create folders for new concatenated and old pdfs and folders of smlal jpgs in the main directory
mkdir "${folder}/concat_jpg"
concat_jpg=""${folder}/concat_jpg""
mkdir "${folder}/og_pdf"
og_pdf=""${folder}/og_pdf""
mkdir "${folder}/small_jpgs"
small_jpgs=""${folder}/small_jpgs""

#read in image height"
echo "enter desired image height (in pixels):"
read height


######## MOVE PDFS INTO FOLDERS OF THEIR OWN NAME ########

find "$folder" -name '*.pdf' -exec mv {} "$small_jpgs" \; 2>/dev/null

echo "1) creating folders for each pdf and moving them into their own folder"
for f in "$small_jpgs"/*; do
	size=${#f} #get size of filename
	let size-=4 #set variable to name of pdf but without .pdf extension
	dir=${f:0:$size} #change filename
	mkdir -p "$dir" && mv "$f" "$dir" #create new file with pdf in it
done
echo "2) all pdfs now in their own folders"



######## CONVERT PDFs INTO CONCATENATED JPGs ########

echo "3) concatenating pdfs and converting to specified size"

shopt -s extglob #enable external global (! = except)

for f in "$small_jpgs"/*; do 

	echo "concatenating "$f""
	#### CONVERSION SET FOR AROUND 300px HEIGHT WITH -density 27.3 ######
	#### INCREASE -density FOR BETTER QUALITY ######
	for i in "$f"/*; do convert -density 27.3 "$i" "$i".jpg; done  #convert pdf to jpg
	mv "$f/$(basename "$f").pdf" "$og_pdf" #move pdf to pdf folder #faster than find

	#if fileheight is not speicified height, convert all files in dir to correct height
	first="$(find "$f" -name '*.jpg' | head -n 1)" #get filename of one file in dir
	ht="$(identify -format "%h" $first)" #identify pixel height of that file
	if (("$ht"!="$height")); then
		for i in "$f"/*; do convert "$i" -resize x$height "$i"; done #change resolution on y axis
	fi

	#concatenate jpgs and put them in the concat_jpg folder
	convert +append "$f"/* "$concat_jpg/$(basename "$f").jpg"

done;

echo "4) finished"

shopt -u extglob #disable external global (! = except)

