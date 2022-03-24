#!/bin/bash
# Run 'make clean' in allmost all subdirectories

for p in `ls */Makefile | egrep -v 'MakefileTemplates' `; do
    d=`dirname $p`
     (
        cd $d
        echo ""
        echo "---- Cleaning example $d ----"
        make clean
    )
done

