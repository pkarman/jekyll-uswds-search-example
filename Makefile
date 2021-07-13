run:
	bundle exec jekyll serve --watch

build:
	bundle exec jekyll build

deps:
	bundle

.PHONY: run build deps
