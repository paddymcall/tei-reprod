EXTRAS = texlive-context texlive-luatex texlive-collection-basic texlive-tex-gyre poppler
TM = guix time-machine -C ../channels.scm -- shell --pure -E "LANG*" --container --share=../=/data -m ../manifest.scm $(EXTRAS) --

all: results.txt

results.txt: results.pdf
	$(TM) pdftotext $< - | sed 's/^.*git-no-git.*$$//' > $@

# Uses a custom CSL style included in guile-stei:
results.pdf: results.tex
	$(TM) context results.tex

results.tex:
	$(TM) run-conversions.scm \
	--homeurl="https://github.com/paddymcall/tei-reprod/tree/main/example-bib-format" \
	--homename="TEI Reprod Tests (GitHub repo)" \
	--bib=./bib.bib \
	--standalone \
	-t ana-rm-private \
	-t xml-normalize-spaces \
	-t tei-fix-spaces \
	-t tei-wit-source-to-bibl \
	-t tei-witDetails-absorb \
	-t tei-inline-things \
	-t tei-punctuate-rdgGrps \
	-t context-basics \
	-t tei-bibl-substitute \
	-t context-serialise \
	tei.xml > "$@"

clean:
	rm -f results.*

.PRECIOUS: results.pdf
.PRECIOUS: results.tex
