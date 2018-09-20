.PHONY: build run release url clean shell

REGISTRY 	  := quay.io
IMAGE_NAME  := coryodaniel/curator
IMAGE_URL  := ${REGISTRY}/${IMAGE_NAME}
TEST_PREFIX := curator-dbg

all: clean build run

url:
	@echo ${IMAGE_URL}

build:
	docker build -t ${IMAGE_NAME} .

release: REL_TIME=$(shell date +%s)
release:
	docker tag ${IMAGE_NAME} ${IMAGE_URL}:latest && \
	docker tag ${IMAGE_NAME} ${IMAGE_URL}:${REL_TIME} && \
	docker push ${IMAGE_URL}:latest && \
	docker push ${IMAGE_URL}:${REL_TIME}

shell: clean
shell:
	docker run --name ${TEST_PREFIX}-shell --entrypoint bash -it ${IMAGE_NAME}:latest

tmp:
	mkdir -p ./tmp

clean:
	@rm -rf ./tmp
	@docker ps --format "{{.Names}}" -a | grep "${TEST_PREFIX}" | xargs docker stop
	@docker ps --format "{{.Names}}" -a | grep "${TEST_PREFIX}" | xargs docker rm

run: tmp
run:
	docker run --name ${TEST_PREFIX} ${IMAGE_NAME}:latest
