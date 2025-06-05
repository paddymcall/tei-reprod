# Call as make LANG=en_US.UTF-8
TM = guix time-machine -C ./channels.scm -- shell --pure -E "LANG*" --container -m ./manifest.scm --

all: help
all: list-converters
all: ./example-bib-format/results-chicago16.xml
all: ./example-type-ana/results.xml
all:
	@echo "Git should not show any changes:"
	git status ./

help:
	$(TM) run-conversions.scm -h

list-converters:
	$(TM) run-conversions.scm -l

./example-bib-format/results-chicago16.xml: ./example-bib-format/results.xml
./example-bib-format/results.xml:
	cd ./example-bib-format/ && make
./example-type-ana/results.xml:
	cd ./example-type-ana/ && make

clean:
	cd ./example-type-ana/ && make clean
	cd ./example-bib-format/ && make clean
