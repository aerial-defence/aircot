# Makefile for Python Team Awareness Kit (PyTAK) Module
#
# Source:: https://github.com/ampledata/aircot
# Author:: Greg Albrecht W2GMD <oss@undef.net>
# Copyright:: Copyright 2021 Orion Labs, Inc.
# License:: Apache License, Version 2.0
#


.DEFAULT_GOAL := all


all: develop

install_requirements:
	pip install -r requirements_test.txt

develop:
	python setup.py develop

install_editable:
	pip install -e .

install_test:
	pip install -r requirements_test.txt

install:
	python setup.py install

uninstall:
	pip uninstall -y aircot

reinstall: uninstall install

clean:
	@rm -rf *.egg* build dist *.py[oc] */*.py[co] cover doctest_pypi.cfg \
		nosetests.xml pylint.log output.xml flake8.log tests.log \
		test-result.xml htmlcov fab.log .coverage __pycache__ \
		*/__pycache__

publish:
	python setup.py publish

pep8:
	flake8 --max-complexity 12 --exit-zero aircot/*.py

flake8: pep8

lint:
	pylint --msg-template="{path}:{line}: [{msg_id}({symbol}), {obj}] {msg}" \
		-r n aircot/*.py || exit 0

pylint: lint

checkmetadata:
	python setup.py check -s --restructuredtext

mypy:
	mypy --strict .

pytest:
	pytest

test: install_editable install_test pytest
