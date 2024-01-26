## commands: show available commands
.PHONY: commands
commands:
	@grep -h -E '^##' ${MAKEFILE_LIST} | sed -e 's/## //g' | column -t -s ':'

## databases: make databases
.PHONY: databases
databases : data/assays.db data/lab_log.db data/penguins.db

## data/assays.db: synthetic experimental data
data/assays.db: bin/create_assays_db.py
	python $< $@

## data/lab_log.db: synthetic experiment records
data/lab_log.db: bin/create_lab_log.py
	python $< $@

## data/penguins.db: penguin data
data/penguins.db : bin/create_penguins_db.sql data/penguins.csv
	sqlite3 $@ < $<

## missing: list unused keywords
.PHONY: missing
missing:
	@python bin/get_sql_features.py --diff data/sql_keywords.txt --markdown < index.md

## renumber: renumber headings
.PHONY: renumber
renumber:
	@python bin/renumber_headings.py index.md

## clean: clean up stray files
.PHONY: clean
clean:
	@rm -f *~
