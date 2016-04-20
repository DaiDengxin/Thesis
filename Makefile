
mainfile = dissertation

all: $(mainfile).pdf

quick: 
	pdflatex $(mainfile)

%.pdf: %.eps
	epstopdf $*.eps
	svn add $*.pdf
#	./embed-fonts.sh $*.eps f$*.pdf

#figures/%.png: figures/%.jpg
#	convert figures/$*.jpg figures/$*.png

#figures/%.png: figures/%.bmp
#	convert figures/$*.bmp figures/$*.png
#	convert figures/$*.bmp -quality $(imquality) figures/$*.jpg
#	jpeg2ps figures/$*.jpg -o figures/$*.eps
#	epstopdf --outfile figures/$*.pdf figures/$*.eps 
#	rm figures/$*.jpg
#	rm figures/$*.eps
#	bmp2tiff -c lzw:2 figures/$*.bmp figures/$*.tiff
#	tiff2pdf -o figures/$*.pdf figures/$*.tiff
#	rm figures/$*.tiff

$(mainfile).pdf: Makefile $(mainfile).pdf $(figures) $(wildcard *.tex) $(wildcard *.bib)  
	pdflatex $(mainfile)
	bibtex   $(mainfile)
	pdflatex $(mainfile)
	pdflatex $(mainfile)

clean:
	rm -f *.log *.aux *.dvi *.bbl *.blg *.brf *.lof *.lot *.toc *.out
