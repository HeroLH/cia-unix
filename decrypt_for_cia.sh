#!/usr/bin/env bash

for ciaFile in `find . -name "*cia"` ; do
  fullFilename=`basename $ciaFile`;                           # xxx.cia
  filename="${fullFilename%.*}";                              # xxx
  echo -e "\033[0;36mReady to decrypt file: $fullFilename \033[0m";

  # decrypt .cia file, generate *.ncch files
  python decrypt.py $fullFilename >> log.txt 2>&1;

  # construct command for makerom
  declare -i i=0;
  ARG="";                                                     # -i xxx.1.ncch:0:0 -i xxx.0.ncch:1:1
  for decryptFile in `find . -name "$filename.*.ncch"`; do
    fullDecryptFilename=`basename $decryptFile`;              # xxx.ncch
      ARG="$ARG -i $fullDecryptFilename:$i:$i "
      i+=1;
  done

  # convert *.ncch to .cia
  echo `makerom -f cia -ignoresign -target p -o $filename-decrypt.cia $ARG`

  # dedlete *.ncch
  for decryptFile in `find . -name "$filename.*.ncch"`; do
    rm $decryptFile;
  done

  # check for success
  if [ -f "$filename-decrypt.cia" ]; then
    echo -e "\033[0;32mDecrypted file successfully: $fullFilename, generate file: $filename-decrypt.cia \033[0m"
  else
    echo -e "\033[0;31m Failed to decrypt the file, see log.txt for details \033[0m"
  fi
done