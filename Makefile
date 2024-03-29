.PHONY: clean test all install docs stubs bump

install:
	source bin/activate && pip install -e .

clean:
	rm -rf build
	rm -rf *.so

test:
	pytest tests/*.py

sphinx:
	cd docs && sphinx-apidoc -o ./source ../src -f && make html

start-runner:
	actions-runner/run.sh

bump:
	bump2version patch --allow-dirty

stubs:
	pybind11-stubgen gravitas --numpy-array-remove-parameters --ignore-all-errors --output-dir src

all: clean install test sphinx stubs bump