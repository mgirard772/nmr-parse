IMAGE_NAME = nmr-parse
REPO_NAME = nmr-parse

prune:
	# Remove dangling images
	docker image prune --filter="dangling=true" -f

build:
	# Always build for linux/amd64 since Github runners are X86_64
	docker build -t $(IMAGE_NAME) --build-arg="PYTHON_VERSION=$$(cat .python-version)" --platform linux/amd64 .
	$(MAKE) prune

run-script: build
	docker-compose run --rm $(IMAGE_NAME) python -u nmr_parse.py $(args)

run-app: build
	docker-compose run -p 443:443 --rm $(IMAGE_NAME) python -u app.py

app-up: build
	docker compose up -d

app-down:
	docker compose down

app-refresh:
	docker compose down -v
	$(MAKE) app-up

test: build
	docker-compose run --rm $(IMAGE_NAME) pytest
