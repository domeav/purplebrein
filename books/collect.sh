#!/bin/bash
shopt -s extglob



pdfunite ../*/C/conductor.pdf PurpleBrein_conductor_C.pdf
pdfunite ../*/C/conductor.pdf PurpleBrein_conductor_C.pdf

for key in C Bb Eb; do
    pdfunite ../*/${key}/conductor.pdf PurpleBrein_conductor_${key}.pdf
    pdfunite $(ls ../*/$key/*_F.pdf) PurpleBrein_${key}_F.pdf
    pdfunite $(ls ../*/$key/*_F_pocket.pdf) PurpleBrein_${key}_F_pocket.pdf
    pdfunite $(ls ../*/$key/*_G.pdf) PurpleBrein_${key}_G.pdf
    pdfunite $(ls ../*/$key/*_G_pocket.pdf) PurpleBrein_${key}_G_pocket.pdf
done
