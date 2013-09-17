# IMAV paper template
#   make        build the example paper (PDF)
#   make clean  remove all LaTeX build files, the PDF and the zip
#   make zip    zip the source files and the built example PDF (no folder in the zip), as distributed to the authors

MAIN    := imav2013-easychair
ZIPNAME := IMAV2013_template
SOURCES := $(MAIN).tex imav2013.cls $(MAIN).bib logoEC.pdf throneEC.jpg chairEC.pdf debug.pdf

LATEX   := pdflatex -interaction=nonstopmode -halt-on-error
BUILD   := aux log out bbl blg toc lof lot hd synctex.gz fdb_latexmk fls

.PHONY: all clean zip

all: $(MAIN).pdf

$(MAIN).pdf: $(SOURCES)
	$(LATEX) $(MAIN)
	bibtex $(MAIN)
	$(LATEX) $(MAIN)
	$(LATEX) $(MAIN)

clean:
	rm -f $(addprefix $(MAIN).,$(BUILD)) $(MAIN).pdf $(ZIPNAME).zip

zip: $(SOURCES) $(MAIN).pdf
	rm -f $(ZIPNAME).zip
	zip -q -X $(ZIPNAME).zip $(SOURCES) $(MAIN).pdf
	@echo "$(ZIPNAME).zip:"; unzip -l $(ZIPNAME).zip | tail -n +4
