#!/usr/bin/env bash

# exit when any command fails
set -e

INPUT_DIR=/home/funkquist/survey-generation/data/survey_generation/acl_pdfs
OUTPUT_DIR=/home/funkquist/survey-generation/data/survey_generation/pdf_parses

eval "$(conda shell.bash hook)"
conda activate doc2json

NR_FAILED_PARSES=0
for entry in "$INPUT_DIR"/*
do
  echo "Parsing file: '$entry'"
  if ! python /home/funkquist/repos/s2orc-doc2json/doc2json/grobid2json/process_pdf.py -i "$entry" -t temp_dir/ -o "$OUTPUT_DIR" ; then
    echo "Failed to parse file: '$entry'"
    # NR_FAILED_PARSES = $((NR_FAILED_PARSES+1))
    let "NR_FAILED_PARSES+=1"
  fi
done

echo "Failed to parse $NR_FAILED_PARSES pdf files"



