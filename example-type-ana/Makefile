# Call as make LANG=en_US.UTF-8
TM = guix time-machine -C ../channels.scm -- shell --pure -E "LANG*" --container -m ../manifest.scm --

results.xml:
	@echo "Before"
	grep --color "<c " tei.xml
	@$(TM) run-conversions.scm -t tei-type-to-ana -t xml-serialise tei.xml > results.xml
	@echo "After"
	grep --color "<tei:c " results.xml
	@echo "Difference: The tei:c elements now have @ana attributes!"

clean:
	rm -f results.*
