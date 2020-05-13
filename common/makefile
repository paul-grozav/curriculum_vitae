fileName := CV.TancrediPaulGrozav

all: pdf

pdf:	
	pdflatex $(fileName).tex # Attempt to generate .pdf (actually generates other files)
#	makeindex $(fileName).idx # Make the table of contents
#	bibtex $(fileName).aux # Make bibliography
#	pdflatex $(fileName).tex # Make .PDF ( cite not working first time )
	pdflatex $(fileName).tex # Make .PDF

open:
	evince $(fileName).pdf & # Open the document with evince PDF viewer

clean:
	rm -Rf $(fileName).pdf
	rm -Rf $(fileName).aux $(fileName).glo $(fileName).idx $(fileName).ist $(fileName).lof $(fileName).log $(fileName).out $(fileName).toc $(fileName).bbl $(fileName).blg $(fileName).ilg $(fileName).ind
	
.PHONY: all
