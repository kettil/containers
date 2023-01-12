#!/bin/bash
set -e

if [[ ! -e "${QPDF_FILE_PASSWORDS}" ]]; then
  echo "ERROR: Password file is not exists"

  exit 1
fi

function pdfDecrypt() {
  cat "${QPDF_FILE_PASSWORDS}" | while read PASSWORD; do
    if [[ "$( qpdf --warning-exit-0 --password="${PASSWORD}" --decrypt "${1}" "${1%/*}/_${1##*/}" 2> /dev/null )$?" == "0" ]]; then
      echo "  => encrypt has been removed"

      mv "${1%/*}/_${1##*/}" "${1}"

      return
    fi
  done
}

for FILE in ${PDFA_FOLDER_SCANS}/*.pdf; do
  # ignore pdfs that start with "_"
  if [[ "$( echo "${FILE}" | xargs basename | cut -c1-1 )" != "_" ]]; then
    echo "${FILE}"

    case "$( qpdf --requires-password "${FILE}" )$?" in
      0)
        echo "  => pdf is encrypted with password"
        pdfDecrypt "${FILE}"
        ;;

      2)
        echo "  => pdf is not encrypted"
        ;;

      3)
        echo "  => pdf is encrypted"

        if [[ "$( qpdf --warning-exit-0 --decrypt "${FILE}" "${FILE%/*}/_${FILE##*/}" )$?" == "0" ]]; then
          echo "  => encrypt has been removed"
          mv "${FILE%/*}/_${FILE##*/}" "${FILE}"
        fi
        ;;

      *)
        echo "  => unknown qpdf exit code"
        ;;
    esac

    mv "${FILE}" "${PDFA_FOLDER_PDFS}/"
    echo ""
  fi
done
