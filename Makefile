.PHONY: inst-build inst-run inst-clear inst-logs inst-bash \
cp-build cp-run cp-clear cp-logs cp-bash

inst-build:
	@echo "* Before Build"
	@if [ -z "$(ver)" ]; then \
		echo "Error: 必須指定 IMAGE VERSION，ex: make inst-build ver=v1"; \
		exit 1; \
	fi
	mkdir -p $(CURDIR)/inst/data
	rm -rf ./inst/src
	mkdir -p ./inst/src
	cp -r ../PG-APP-Core/src ./inst/src
	rm -rf ./inst/src/scripts
	rm -rf ./inst/src/__pycache__
	rm -rf ./inst/src/core/v1
	rm -rf ./inst/src/core/__pycache__
	cp ./inst/.env ./inst/src/core/v2/inst/.env

	@echo "* Build"
	docker build -t pg-python-inst:$(ver) -f ./inst/Dockerfile . --no-cache
	@echo "✅  <make inst-build> done."

inst-run:
	@echo "* Run"
	@if [ -z "$(ver)" ]; then \
		echo "Error: 必須指定 IMAGE VERSION，ex: make inst-run ver=v1"; \
		exit 1; \
	fi
	docker run -d \
	  --name pg-python-edge-01 \
	  --env-file ./inst/.env \
	  --add-host host.docker.internal:host-gateway \
	  -v $(CURDIR)/inst/data:/app/data \
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
	mkdir -p $(CURDIR)/cp/data
	rm -rf ./cp/src
	mkdir -p ./cp/src
	cp -r ../PG-APP-Core/src ./cp/src
	rm -rf ./cp/src/scripts
	rm -rf ./cp/src/__pycache__
	rm -rf ./cp/src/core/v1
	rm -rf ./cp/src/core/__pycache__
	cp ./cp/.env ./cp/src/core/v2/cp/.env

	@echo "* Build"
	docker build -t pg-python-cp:$(ver) -f ./cp/Dockerfile . --no-cache
	@echo "✅  <make cp-build> done."

cp-run:
	@echo "* Run"
	@if [ -z "$(ver)" ]; then \
		echo "Error: 必須指定 IMAGE VERSION，ex: make cp-run ver=v1"; \
		exit 1; \
	fi
	docker run -d \
	  --name pg-python-cp \
	  --env-file ./cp/.env \
	  --add-host host.docker.internal:host-gateway \
	  -v $(CURDIR)/cp/data:/app/data \
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