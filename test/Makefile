VALE := ../docs/.crate-docs/tools/vale

test:
	@# Just for having humanized output.
	-cat bad-style-01.rst.camouflage | $(VALE) --config=bad-style-01.vale.ini

	@# Assert that four (4) items are reported by Vale.
	$(eval ERROR_COUNT=$(shell cat bad-style-01.rst.camouflage | $(VALE) --config=bad-style-01.vale.ini --output=JSON | jq '.["stdin.txt"] | length'))
	@test $(ERROR_COUNT) -eq 4 || (echo; echo ERROR: Validating Vale failed && exit 1)
