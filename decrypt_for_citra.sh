#!/usr/bin/env bash

CiaFileDirName="cia"
CiaDecryptFileDirName="cia-decrypt"

# check if a directory named cia exists in the current directory
if [ ! -d $CiaFileDirName ]; then
  echo -e "\033[0;33mWarning: You need to create a folder called \"cia\" and put the cia files into that folder \033[0m"
  exit 1
fi

# batch decrypt cia file
for ciaFile in `find ./$CiaFileDirName/ -name "*.cia"` ; do
  fullFilename=`basename $ciaFile`;                           # xxx.cia
  filename="${fullFilename%.*}";                              # xxx
  echo -e "\033[0;36mReady to decrypt file: $fullFilename \033[0m";
  # decrypt .cia file, generate *.ncch files
  python decrypt.py "./$CiaFileDirName/$fullFilename" >> log.txt 2>&1;
  # construct command for makerom
  declare -i i=0;
  ARG="";                                                     # -i xxx.1.ncch:0:0 -i xxx.0.ncch:1:1
  for decryptFile in `find . -name "$filename.*.ncch"`; do
    fullDecryptFilename=`basename $decryptFile`;              # xxx.ncch
      ARG="$ARG -i $fullDecryptFilename:$i:$i "
      i+=1;
  done
  # convert *.ncch to .cia
  decryptCiaFilename="$filename-decrypt.cia"
  echo `makerom -f cia -ignoresign -target t -o $decryptCiaFilename $ARG`
  # dedlete *.ncch
  for decryptFile in `find . -name "$filename.*.ncch"`; do
    rm $decryptFile;
  done
  # check for success
  if [ -f "$decryptCiaFilename" ]; then
    # copy the decrypt .cia file to specify directory
    if [ ! -d $CiaDecryptFileDirName ]; then
      mkdir $CiaDecryptFileDirName
    fi
    mv $decryptCiaFilename $CiaDecryptFileDirName
    echo -e "\033[0;32mDecrypted file successfully: $fullFilename, generate file: $CiaDecryptFileDirName/$decryptCiaFilename \033[0m"
  else
    echo -e "\033[0;31m Failed to decrypt the file, see log.txt for details \033[0m"
  fi
done

