# IMAV paper template
#   make        build the example paper (PDF)
#   make clean  remove all LaTeX build files, the PDF and the zip
#   make zip    zip the source files and the built example PDF (no folder in the zip), as distributed to the authors

MAIN    := imav_template
ZIPNAME := imav_style_latex
SOURCES := $(MAIN).tex imav.sty imav_bibliography.bib BIT_NUS_logo.eps BIT_NUS_logo.pdf build.bat kanjix.map
# the figure as EPS for latex (ROUTE dvi, build.bat) and as PDF for pdflatex (ROUTE pdf)
# build.bat: the build on Windows without make (MiKTeX); kanjix.map: empty, MiKTeX's dvipdfm needs it
# dvi: latex + dvipdfmx (needed for EPS figures); pdf: pdflatex
ROUTE   := dvi

BUILD   := aux log out bbl blg toc lof lot hd dvi synctex.gz fdb_latexmk fls

.PHONY: all clean zip

all: $(MAIN).pdf

ifeq ($(ROUTE),dvi)
LATEX   := latex -interaction=nonstopmode -halt-on-error
$(MAIN).pdf: $(SOURCES)
	$(LATEX) $(MAIN)
	bibtex $(MAIN)
	$(LATEX) $(MAIN)
	$(LATEX) $(MAIN)
	dvipdfmx -q $(MAIN)
else
LATEX   := pdflatex -interaction=nonstopmode -halt-on-error
$(MAIN).pdf: $(SOURCES)
	$(LATEX) $(MAIN)
	bibtex $(MAIN)
	$(LATEX) $(MAIN)
	$(LATEX) $(MAIN)
endif

clean:
	rm -f $(addprefix $(MAIN).,$(BUILD)) $(MAIN).pdf $(ZIPNAME).zip

zip: $(SOURCES) $(MAIN).pdf
	rm -f $(ZIPNAME).zip
	zip -q -X $(ZIPNAME).zip $(SOURCES) $(MAIN).pdf
	@echo "$(ZIPNAME).zip:"; unzip -l $(ZIPNAME).zip | tail -n +4
