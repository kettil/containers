FROM debian:bookworm-20221114-slim

ENV PDFA_FOLDER_SCANS=/scans
ENV PDFA_FOLDER_PDFS=/pdfs

RUN apt-get update && apt-get install -y \
  imagemagick libtiff-tools libtiff-dev pdftk \
  tesseract-ocr tesseract-ocr-eng tesseract-ocr-deu \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -p ${PDFA_FOLDER_SCANS} ${PDFA_FOLDER_PDFS} \
  && chown -R 1003:1003 ${PDFA_FOLDER_SCANS} ${PDFA_FOLDER_PDFS}

COPY --chown=1003:1003 --chmod=500 batch.sh   /batch.sh
COPY --chown=1003:1003 --chmod=500 convert.sh /convert.sh

USER 1003:1003

ENTRYPOINT [ "/batch.sh" ]
