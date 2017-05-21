#!/bin/bash

FORCE="$1"
SYNTAX="$2"
EXTENSION="$3"
OUTPUTDIR="$4"
INPUT="$5"
CSSFILE="$6"

FILE=$(basename "$INPUT")
FILENAME=$(basename "$INPUT" .$EXTENSION)
FILEPATH=${INPUT%$FILE}
OUTDIR=${OUTPUTDIR%$FILEPATH*}
OUTPUT="$OUTDIR"/$FILENAME
CSSFILENAME=$(basename "$6")

# Changes [[foo|bar]] -> <a href="foo.html">bar</a>
FIRSTPASS=$(cat "$INPUT" | sed -E 's/\[\[([^\|]*)\|([^\|]*)\]\]/\<a href="\1.html"\>\2<\/a\>/g')

# Changes [[foobar]] -> <a href="foobar.html">foobar</a>
SECONDPASS=$(echo "$FIRSTPASS" | sed -E 's/\[\[([^\|]*)\]\]/\<a href="\1.html"\>\1<\/a\>/g')

echo "$SECONDPASS" | pandoc -s -f $SYNTAX -t html -c $CSSFILENAME > "$OUTPUT.html";

