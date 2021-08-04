.PHONY: build
build:
	docker-compose build

.PHONY: test
test:
	docker-compose run --rm app rake test
