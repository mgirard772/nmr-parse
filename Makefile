IMAGE_NAME = nmr-parse
REPO_NAME = nmr-parse
TEST_STRING = "158.05 (d, J = 253.6 Hz), 152.26, 138.67, 138.30 (d, J = 8.3 Hz), 138.12, 137.63, 137.44, 128.30, 128.22, 128.03, 127.88, 127.80, 127.75, 127.67, 127.59, 127.55, 124.36 (d, J = 4.1 Hz), 124.05 (d, J = 19.5 Hz), 86.65, 84.30, 80.81, 79.06, 77.77, 75.57, 75.27, 74.89, 73.25, 68.98"
SHELL := /bin/bash

prune:
	# Remove dangling images
	docker image prune --filter="dangling=true" -f

build:
	# Always build for linux/amd64 since Github runners are X86_64
	docker build -t $(IMAGE_NAME) --build-arg="PYTHON_VERSION=$$(cat .python-version)" --platform linux/amd64 .
	$(MAKE) prune

run-script: build
	docker run --rm -v $$(pwd)/src/:/$(REPO_NAME)/src $(IMAGE_NAME) python -u nmr_parse.py $(args)

run-app: build
	docker run --rm -v $$(pwd)/src/:/$(REPO_NAME)/src -p 12345:12345 $(IMAGE_NAME) python -u app.py

app-up: build
	docker compose up -d

app-down:
	docker compose down

app-refresh: build
	docker compose down -v
	$(MAKE) app-up

test: build
	docker run --rm -v $$(pwd)/src/:/$(REPO_NAME)/src $(IMAGE_NAME) pytest

benchmark-docker: build
	docker run --rm -v $$(pwd)/src/:/$(REPO_NAME)/src $(IMAGE_NAME) python -m  timeit -c \
		'import nmr_parse; nmr_parse.parse_nmr($(TEST_STRING))'

benchmark-local:
	source .venv/bin/activate && \
	cd src && \
	python -m  timeit -c 'import nmr_parse; nmr_parse.parse_nmr($(TEST_STRING))'

