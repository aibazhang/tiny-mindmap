#!/bin/bash
mkdir -p ./html/tech ./html/nontech 
files=`find ./ -type f -name "*.md" ! -name "README.md" ! -path "./node_modules/*"`

for file in $files;
do
  output_file="${file/md/html}"
  echo "transforming $file to $output_file"
  node_modules/.bin/markmap $file -o $output_file.html --no-open #tr
done

find ./html -type f -name "*.html" ! -name "index.html" | \
  awk '{print "\""$0"\","}' | \
  xargs -0 -I{} awk -v list={} '{sub(/HTML_FILE_LIST/, list); print}' \
  index.html.sample > index.html