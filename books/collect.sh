#!/bin/bash
shopt -s extglob



for key in C Bb Eb; do
    ./pdfmerger.py -o PurpleBrein_conductor_${key} ../*/${key}/conductor.pdf
    ./pdfmerger.py -o PurpleBrein_${key}_F $(ls ../*/$key/*_F.pdf)
    ./pdfmerger.py -o PurpleBrein_${key}_F_pocket $(ls ../*/$key/*_F_pocket.pdf)
    ./pdfmerger.py -o PurpleBrein_${key}_G $(ls ../*/$key/*_G.pdf)
    ./pdfmerger.py -o PurpleBrein_${key}_G_pocket $(ls ../*/$key/*_G_pocket.pdf)
    ./pdfmerger.py -o PurpleBrein_Bass_Bb_F_pocket $(ls ../*/Bb/Bass_F_pocket.pdf)
done
