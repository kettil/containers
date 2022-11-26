#!/bin/bash
set -e

SCAN_IMAGE_FOLDER="${1}"

cd "${PDFA_FOLDER_SCANS}/${SCAN_IMAGE_FOLDER}"

rm -rf ./pdf_*.pdf

for i in scan_*.tif; do
  echo "${SCAN_IMAGE_FOLDER} : tesseract (${i})"
  tesseract ${i} pdf_${i:5:-4} --dpi 600 -l deu+eng pdf
done

echo "${SCAN_IMAGE_FOLDER} : merging single pdf pages"
pdftk pdf_*.pdf cat output pdf_merge.pdf flatten

echo "${SCAN_IMAGE_FOLDER} : create pdf/A"
gs  -dPDFA -dBATCH -dNOPAUSE -dQUIET -dNOOUTERSAVE \
    -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer \
    -sProcessColorModel=DeviceCMYK -sDEVICE=pdfwrite \
    -sPDFACompatibilityPolicy=1 -sOutputFile="${SCAN_IMAGE_FOLDER}.pdf" \
    pdf_merge.pdf

chmod 777 "${SCAN_IMAGE_FOLDER}.pdf"

echo "${SCAN_IMAGE_FOLDER} : pdf will be moved to the destination folder"
mv "${SCAN_IMAGE_FOLDER}.pdf" "${PDFA_FOLDER_PDFS}/${SCAN_IMAGE_FOLDER}.pdf"

echo "${SCAN_IMAGE_FOLDER} : remove the folder"
rm -rf "${PDFA_FOLDER_SCANS}/${SCAN_IMAGE_FOLDER}"
