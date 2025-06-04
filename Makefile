# Call as make LANG=en_US.UTF-8
TM = guix time-machine -C ./channels.scm -- shell --pure -E "LANG*" --container -m ./manifest.scm --

all: help list-converters

help:
	$(TM) run-conversions.scm -h

list-converters:
	$(TM) run-conversions.scm -l

