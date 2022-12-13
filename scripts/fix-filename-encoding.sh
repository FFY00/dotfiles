#!/bin/sh
echo "renaming:"
find . -print0 | tac -s '' | while IFS= read -d '' f ;
do
    Odir=$(dirname "$f")   # original location
    Ofile=$(basename "$f") # original filename
    newFile=$Ofile
    # remove unwanted characters
    newFile=$(echo $newFile | tr -d ",'\"?()[]{}\\!")
    newFile="${newFile// /_}"  # Replace spaces with _
    newFile="${newFile//&/n}"  # Replace ampersand with n
    newFile="${newFile//@/a}"  # Replace at sign with a
    newFile=$( iconv -f GBK <<< "$newFile" )
    if [[ "$Ofile" != "$newFile" ]]; then # act if something has changed
      echo "$Odir/$Ofile to"
      echo "$Odir/$newFile"
      mv -i "$Odir/$Ofile" "$Odir/$newFile"
      echo ""
    fi
done
echo "done."
