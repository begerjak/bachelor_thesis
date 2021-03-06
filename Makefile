DVIPS = dvips
LATEX = latex
PDFLATEX = pdflatex -shell-escape
BIBTEX = bibtex
PROJECT = thesis-begerjak-2016
EDITOR = emacs # nebo jiny oblibeny editor
GV = gv # nebo ghostview

all: $(PROJECT).tex
	$(PDFLATEX) $(PROJECT).tex
	makeindex $(PROJECT).nlo -s nomencl.ist -o $(PROJECT).nls
	$(PDFLATEX) $(PROJECT).tex
	
edit:
	$(EDITOR) $(PROJECT).tex &

ref:	$(PROJECT).tex
	$(PDFLATEX) $(PROJECT).tex
	bibtex $(PROJECT)
	$(PDFLATEX) $(PROJECT).tex
	$(PDFLATEX) $(PROJECT).tex

bib:
	$(BIBTEX) $(PROJECT)

gv: $(PROJECT).ps
	$(GV) $< &

acr: $(PROJECT).pdf
	acroread $< &

# PDFko lze vytvorit primo pomoci pdflatexu, ktery vklada obrazky ve formatu PDF
$(PROJECT).pdf: *.tex
	$(PDFLATEX) $<

# nebo konverzi z postscriptu. Tato moznost zase akceptuje jen postscriptove obrazky.
#$(PROJECT).pdf: *.ps
#	ps2pdf -s PAPERSIZE=a4 $<

# Odkomentujte/zakomentujte podle potreby.

$(PROJECT).ps: *.tex
	$(LATEX) $<

	
clean:
	rm -f *.log *.aux *.bbl *.blg *.lof *.lot *.dvi *.toc *.out *~ *.ps *.ilg *.nlo
