#! /usr/bin/env python
# Original author Nicholas Kim, modified by Yan Pashkovsky
# New license - GPL v3
import sys
import time
import PyPDF2
from PyPDF2 import PdfReader, PdfWriter

def eprint(*args, **kwargs):
    """Print to stderr

    Taken from https://stackoverflow.com/a/14981125/7564988
    """
    print(*args, file=sys.stderr, **kwargs)

def get_cmdline_arguments():
    """Retrieve command line arguments."""

    from optparse import OptionParser

    usage_string = "%prog [-o output_name] file1, file2 [, ...]"

    parser = OptionParser(usage_string)
    parser.add_option(
        "-o", "--output",
        dest="output_filename",
        default=time.strftime("output_%Y%m%d_%H%M%S"),
        help="specify output filename (exclude .pdf extension); default is current date/time stamp"
    )

    options, args = parser.parse_args()
    if len(args) < 2:
        parser.print_help()
        sys.exit(1)
    return options, args

def main():
    options, filenames = get_cmdline_arguments()
    output_pdf_name = options.output_filename + ".pdf"
    files_to_merge = []

    # get PDF files
    for f in filenames:
        try:
            next_pdf_file = PdfReader(open(f, "rb"))
        except(PyPDF2._utils.PdfStreamError):
            eprint("%s is not a valid PDF file." % f)
            sys.exit(1)
        except(IOError):
            eprint("%s could not be found." % f)
            sys.exit(1)
        else:
            files_to_merge.append(next_pdf_file)

    # merge page by page
    output_pdf_stream = PdfWriter()
    j=0
    k=0
    for f in files_to_merge:
        for i in range(len(f.pages)):
            output_pdf_stream.add_page(f.pages[i])
            if i==0:
                output_pdf_stream.add_outline_item(str(filenames[k]),j)
            j = j + 1
        k += 1

    # create output pdf file
    try:
        output_pdf_file = open(output_pdf_name, "wb")
        output_pdf_stream.write(output_pdf_file)
    finally:
        output_pdf_file.close()

    print("%s successfully created." % output_pdf_name)


if __name__ == "__main__":
    main()
