make:
	make Tl0.pdf
	make Tp0.pdf

Tl0.pdf: Tl0.dot

Tp0.pdf: Tp0.dot

%.pdf: %.dot
	neato -Tpdf $< > $@

clean:
	rm -f Tl0.pdf
	rm -f Tp0.pdf
