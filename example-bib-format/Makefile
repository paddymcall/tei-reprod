TM = guix time-machine -C ../channels.scm -- shell --pure -E "LANG*" --container -m ../manifest.scm --
CSLSTYLE = chicago-author-date-16th-edition.csl

all: results.xml results-chicago16.xml

# Uses a custom CSL style included in guile-stei:
results.xml:
	@$(TM) run-conversions.scm -t tei-bibl-substitute -t xml-serialise tei.xml > $@


# With a built in CSL style
substitute-bibs:


# With Chicago 16th style
results-chicago16.xml: chicago-author-date-16th-edition.csl
	@$(TM) run-conversions.scm --csl-style=$(CSLSTYLE) -t tei-bibl-substitute -t xml-serialise tei.xml > $@

$(CSLSTYLE):
	wget https://raw.githubusercontent.com/ea-east/styles/refs/heads/master/$(CSLSTYLE)

clean:
	rm -f results*.xml
