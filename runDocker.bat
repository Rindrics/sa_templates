#! /bin/sh
docker run --rm -it -w=/root -v ${PWD}:/root eisoku9618/kuroiwa_dockefiles_for_latexmk /bin/bash -c "latexmk -pvc fish1.tex"
open ./.tmp/fish1.pdf
