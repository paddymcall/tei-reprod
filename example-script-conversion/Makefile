# Call as make LANG=en_US.UTF-8
# Container is isolated from host, so use “--share” option to access data
TM = guix time-machine -C ../channels.scm -- shell --pure -E "LANG*" --container --share=../=/data -m ../manifest.scm --

all: results.xml
all: results.txt

# Ensure @xml:lang is inherited, convert iast to deva, produce xml
results.xml:
	$(TM) run-conversions.scm --xml-lang -t tei-iast-to-deva -t xml-serialise \
	/data/sanskrit-tei-repos/SARIT-corpus/jitari-jatinirakrti.xml > $@

# Much the same, but standoff tei:notes, convert devanāgarī to iast, and output only body
results.txt:
	$(TM) run-conversions.scm --xml-lang  \
	-t tei-standoff \
	-t tei-deva-to-iast \
	-t tei-only-body \
	-t xml-to-text \
	/data/sanskrit-tei-repos/SARIT-corpus/dvadasara_nayacakra.xml > $@

clean:
	rm -f results.*

