##########################################################################################################
# Script to convert a bunch of PDF's into a bunch extracted .TXT's
# requires pdf2text (brew install poppler on OSX)
#
# Usage:
#output
#
# 1 folders created in the destination location:
# /txt:			converted txt's
#
# Marko Stamenovic
# March 27, 2016
# University or Rochester
# GPL Open License
##########################################################################################################

echo "enter folder of PDF dataset for conversion:"
read folder

echo "enter destination of txt folder:"
read dest

mkdir "${dest}/txt"
txt=""${dest}/txt""

for f in "$folder"/*; do
	echo "converting to txt: "$f""
	pdftotext "$f" "$txt/$(basename "$f").txt"
done