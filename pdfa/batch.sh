#!/bin/bash
set -e

for i in ${PDFA_FOLDER_SCANS}/*; do
  # only folder
  if [ -d "$i" ]; then
    PDFA_FOLDER_NAME="$(basename "${i}")"
    # ignore folders beginning with "_"
    if [ "${PDFA_FOLDER_NAME:0:1}" != "_" ]; then
      echo "Found the folder ${i}"
      /convert.sh "${PDFA_FOLDER_NAME}"
    fi
  fi
done
