# pdfJpg.sh
Bash script to convert a bunch of PDF's in a folder into a bunch concatenated JPG's of a given height

requires Imagemagick (available on pip on OSX or apt-get on linux)

## Usage
```
cd /path/to/script

./pdfJpg.sh
```
follow prompts

## Output

3 folders created in the original dataset location:

original pdfs:
```
/og_pdf
```
pagewise jpgs:
```
/small_jpgs
```
concatenated jpgs:
```
/concat_jpg
```
# pdfTxt.sh
Script to convert a bunch of PDF's into a bunch extracted .TXT's

requires pdf2text (brew install poppler on OSX)

## Usage
```
cd /path/to/script

./pdfTxt.sh
```
follow prompts

## Output

1 folders created in the destination location:

converted txt's:
```
/txt			
```
# additional

additional scripts if needed

