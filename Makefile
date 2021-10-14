ci: base test

test:
	docker build -f Dockerfile.ci --build-arg CC_TEST_REPORTER_ID=$$CC_TEST_REPORTER_ID .

base:
	docker build -t automator .
