FROM debian:bookworm-20221114-slim

ENV PDFA_FOLDER_SCANS=/scans
ENV PDFA_FOLDER_PDFS=/pdfs
ENV QPDF_FILE_PASSWORDS=/scans/pwd.txt

RUN apt-get update && apt-get install -y \
  imagemagick libtiff-tools libtiff-dev pdftk qpdf \
  tesseract-ocr tesseract-ocr-eng tesseract-ocr-deu \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -p ${PDFA_FOLDER_SCANS} ${PDFA_FOLDER_PDFS} \
  && chown -R 1003:1003 ${PDFA_FOLDER_SCANS} ${PDFA_FOLDER_PDFS}

COPY --chown=1003:1003 --chmod=500 batch.sh   /batch.sh
COPY --chown=1003:1003 --chmod=500 convert.sh /convert.sh
COPY --chown=1003:1003 --chmod=500 decrypt.sh /decrypt.sh

USER 1003:1003

VOLUME [ "/scans", "/pdfs" ]

ENTRYPOINT [ "/batch.sh" ]
