#!/bin/bash

pdfunite ../*/C/conductor.pdf PurpleBrein_conductor_C.pdf

for key in C Bb Eb; do
    pdfunite $(ls ../*/$key/{Bass_$key,*bassClef}.pdf) PurpleBrein_${key}_bassClef.pdf
    pdfunite $(ls ../*/$key/{*[^Bass]_$key,*_${key}_trebleClef}.pdf) PurpleBrein_${key}_trebleClef.pdf
done
