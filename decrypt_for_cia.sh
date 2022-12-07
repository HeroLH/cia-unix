#!/usr/bin/env bash

for ciaFile in `find . -name "*cia"` ; do
  fullFilename=`basename $ciaFile`;
  filename="${fullFilename%.*}";
  echo -e "\033[0;36mReady to decrypt file: $fullFilename \033[0m";

  makerom -ciatocci $ciaFile
  cciFullFilename="$filename.cci"
  python decrypt.py $cciFullFilename >> log.txt 2>&1;
  declare -i i=0;
  ARG="";
  for decryptFile in `find . -name "$filename.*.ncch"`; do
    fullDecryptFilename=`basename $decryptFile`;
      echo $fullDecryptFilename;
      ARG="$ARG -i $fullDecryptFilename:$i:$i "
      i+=1;
  done
  echo $ARG
  echo `makerom -f cci -ignoresign -target p -o $filename-decrypt.cci $ARG`
  for decryptFile in `find . -name "$filename.*.ncch"`; do
    rm $decryptFile;
  done
  rm $cciFullFilename;
  echo -e "\033[0;32mDecrypted file successfully: $fullFilename \033[0m"
done