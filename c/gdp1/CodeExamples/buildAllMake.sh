#!/bin/bash
# Run 'make' in allmost all subdirectories

for p in `ls */Makefile | egrep -v 'MakefileTemplates' `; do
    d=`dirname $p`
     (
        cd $d
        echo ""
        echo "---- Building example $d ----"
        make
    )
done

