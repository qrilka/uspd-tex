%.pdf:%.tex
	xelatex $<
	xelatex $<

all: example.pdf

.PHONY: clean

.DEFAULT: all

clean:
	rm -f *.log *.aux *.pdf *.eps *.out *.toc


