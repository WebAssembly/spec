#!/bin/sh

cd `dirname $0`/..

FILES=`ls */*.rst`
ERRORS=0

for XREF in `grep "[\\]xref" util/macros.def`; do
  if echo $XREF | grep -q "[|]"; then
    MACRO=`echo $XREF | sed 's/^[^|]*[|]//g' | sed 's/[|].*$//g'`
  elif echo $XREF | grep -q xref; then
    FILE=`echo $XREF | sed 's/^.*xref{//g' | sed 's/}.*$//g'`.rst
    LABEL=`echo $XREF | sed 's/^[^}]*}{//g' | sed 's/}.*$//g'`
    TARGET=".. _$LABEL:"
    if ! [ -f $FILE ] || ! grep -q "$TARGET" $FILE; then
      ERRORS=1
      echo Undefined cross-reference $FILE:$LABEL in macro "|$MACRO|"
      if ! [ -f $FILE ]; then
        echo ...non-existent file $FILE
      fi
      if grep -q "$TARGET" $FILES; then
        echo ...defined in `grep -l "$TARGET" $FILES`
      fi
    fi
  fi
done

if [ $ERRORS -eq 0 ]; then
  echo All cross-references okay.
else
  exit 1;
fi
