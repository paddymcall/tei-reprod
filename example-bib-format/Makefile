TM = guix time-machine -C ../channels.scm -- shell --pure -E "LANG*" --container -m manifest.scm --
CSLSTYLE = chicago-author-date-16th-edition.csl

# With a built in CSL style
substitute-bibs:
	$(TM) run-conversions.scm -t tei-bibl-substitute -t xml-serialise tei.xml

# With Chicago 16th style
substitute-bibs-chicago-16th: chicago-author-date-16th-edition.csl
	$(TM) run-conversions.scm --csl-style=$(CSLSTYLE) -t tei-bibl-substitute -t xml-serialise tei.xml

list-converters:
	$(TM) run-conversions.scm -l

$(CSLSTYLE):
	wget https://raw.githubusercontent.com/ea-east/styles/refs/heads/master/$(CSLSTYLE)

