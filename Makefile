.PHONY: inst-build inst-run inst-clear inst-logs inst-bash \
cp-build cp-run cp-clear cp-logs cp-bash

inst-build:
	@echo "* Before Build"
	@if [ -z "$(ver)" ]; then \
		echo "Error: 必須指定 IMAGE VERSION，ex: make inst-build ver=v1"; \
		exit 1; \
	fi
	mkdir -p $(CURDIR)/docker/inst/data
	rm -rf ./docker/inst/src
	mkdir -p ./docker/inst/src
	cp -r ../PG-APP-Core/src ./docker/inst
	rm -rf ./docker/inst/src/scripts
	rm -rf ./docker/inst/src/__pycache__
	rm -rf ./docker/inst/src/core/v1
	rm -rf ./docker/inst/src/core/__pycache__
	rm -rf ./docker/inst/src/core/v2/api
	rm -rf ./docker/inst/src/core/v2/cp
	rm -rf ./docker/inst/src/core/v2/scripts
	cp ./docker/inst/.env ./docker/inst/src/core/v2/inst/.env

	@echo "* Build"
	docker build -t pg-python-inst:$(ver) -f ./docker/inst/Dockerfile . --no-cache
	@echo "✅  <make inst-build> done."

inst-run:
	@echo "* Run"
	@if [ -z "$(ver)" ]; then \
		echo "Error: 必須指定 IMAGE VERSION，ex: make inst-run ver=v1"; \
		exit 1; \
	fi
	docker run -d \
	  --name pg-python-edge-01 \
	  --env-file ./docker/inst/.env \
	  --add-host host.docker.internal:host-gateway \
	  -v $(CURDIR)/docker/inst/data:/app/data \
	  pg-python-inst:$(ver)
	@echo "✅  <make inst-run> done."

inst-clear:
	@if [ -z "$(name)" ]; then \
		echo "Error... ex: make inst-clear name=pg-python-edge-01"; \
		exit 1; \
	fi
	docker stop $(name)
	docker rm $(name)
	@echo "✅  <make inst-clear> done."

inst-logs:
	@if [ -z "$(name)" ]; then \
		echo "Error... ex: make inst-logs name=pg-python-edge-01"; \
		exit 1; \
	fi
	docker logs -f $(name)
	@echo "✅  <make inst-logs> done."

inst-bash:
	@if [ -z "$(name)" ]; then \
		echo "Error... ex: make inst-bash name=pg-python-edge-01"; \
		exit 1; \
	fi
	docker exec -it $(name) bash
	@echo "✅  <make inst-bash> done."

cp-build:
	@echo "* Before Build"
	@if [ -z "$(ver)" ]; then \
		echo "Error: 必須指定 IMAGE VERSION，ex: make cp-build ver=v1"; \
		exit 1; \
	fi
	#mkdir -p $(CURDIR)/docker/cp/data
	rm -rf ./docker/cp/src
	mkdir -p ./docker/cp/src
	cp -r ../PG-APP-Core/src ./docker/cp
	rm -rf ./docker/cp/src/scripts
	rm -rf ./docker/cp/src/__pycache__
	rm -rf ./docker/cp/src/core/v1
	rm -rf ./docker/cp/src/core/__pycache__
	rm -rf ./docker/cp/src/core/v2/api
	rm -rf ./docker/cp/src/core/v2/inst
	rm -rf ./docker/cp/src/core/v2/scripts
	cp ./docker/cp/.env ./docker/cp/src/core/v2/cp/.env

	@echo "* Build"
	docker build -t pg-python-cp:$(ver) -f ./docker/cp/Dockerfile . --no-cache
	@echo "✅  <make cp-build> done."

cp-run:
	@echo "* Run"
	@if [ -z "$(ver)" ]; then \
		echo "Error: 必須指定 IMAGE VERSION，ex: make cp-run ver=v1"; \
		exit 1; \
	fi
	docker run -d \
	  --name pg-python-cp \
	  --env-file ./docker/cp/.env \
	  --add-host host.docker.internal:host-gateway \
	  -v $(CURDIR)/docker/cp/data:/app/data \
	  pg-python-cp:$(ver)
	@echo "✅  <make cp-run> done."

cp-clear:
	@if [ -z "$(name)" ]; then \
		echo "Error... ex: make cp-clear name=pg-python-cp"; \
		exit 1; \
	fi
	docker stop $(name)
	docker rm $(name)
	@echo "✅  <make cp-clear> done."

cp-logs:
	@if [ -z "$(name)" ]; then \
		echo "Error... ex: make cp-logs name=pg-python-cp"; \
		exit 1; \
	fi
	docker logs -f $(name)
	@echo "✅  <make cp-logs> done."

cp-bash:
	@if [ -z "$(name)" ]; then \
		echo "Error... ex: make cp-bash name=pg-python-cp"; \
		exit 1; \
	fi
	docker exec -it $(name) bash
	@echo "✅  <make cp-bash> done."