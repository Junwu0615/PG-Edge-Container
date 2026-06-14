REGISTRY_HOST := 127.0.0.1:5100

.PHONY: inst-build inst-run inst-clear inst-logs inst-bash inst-push inst-status inst-copy \
cp-build cp-run cp-clear cp-logs cp-bash cp-push cp-status cp-copy


inst-copy:
	@echo "* Copy src From PG-APP-Core"
	mkdir -p $(CURDIR)/inst/data
	rm -rf ./inst/src
	mkdir -p ./inst/src
	cp -r ../PG-APP-Core/src ./inst
	rm -rf ./inst/src/scripts
	rm -rf ./inst/src/__pycache__
	rm -rf ./inst/src/core/v1
	rm -rf ./inst/src/core/__pycache__
	rm -rf ./inst/src/core/v2/api
	rm -rf ./inst/src/core/v2/cp
	rm -rf ./inst/src/core/v2/scripts
	cp ./inst/.env ./inst/src/core/v2/inst/.env
	@echo "✅  <make inst-copy> done."

inst-build:
	@if [ -z "$(ver)" ]; then \
		echo "Error: 必須指定 IMAGE VERSION，ex: make inst-build ver=v1"; \
		exit 1; \
	fi
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

inst-push:
	@echo "* Run"
	@if [ -z "$(image)" ]; then \
		echo "Error: 必須指定 VERSION，ex: make inst-push image=??? registry=???"; \
		exit 1; \
	fi
	@if [ -z "$(registry)" ]; then \
		echo "Error: 必須指定 VERSION，ex: make inst-push image=??? registry=???"; \
		exit 1; \
	fi
	docker tag pg-python-inst:$(image) $(REGISTRY_HOST)/pg-python-inst:$(registry)
	docker push $(REGISTRY_HOST)/pg-python-inst:$(registry)

	curl http://$(REGISTRY_HOST)/v2/pg-python-inst/tags/list
	skopeo inspect --tls-verify=false docker://$(REGISTRY_HOST)/pg-python-inst:$(registry) | jq '{Created, Architecture, RepoTags}'

	@echo "✅  <make inst-push image=$(image) registry=$(registry)> done."

inst-status:
	@if [ -z "$(registry)" ]; then \
		echo "Error: 必須指定 VERSION，ex: make inst-status registry=???"; \
		exit 1; \
	fi
	curl http://$(REGISTRY_HOST)/v2/pg-python-inst/tags/list
	skopeo inspect --tls-verify=false docker://$(REGISTRY_HOST)/pg-python-inst:$(registry) | jq '{Created, Architecture, RepoTags}'
	@echo "✅  <make inst-status registry=$(registry)> done."

cp-copy:
	@echo "* Copy src From PG-APP-Core"
	mkdir -p $(CURDIR)/cp/data
	rm -rf ./cp/src
	mkdir -p ./cp/src
	cp -r ../PG-APP-Core/src ./cp
	rm -rf ./cp/src/scripts
	rm -rf ./cp/src/__pycache__
	rm -rf ./cp/src/core/v1
	rm -rf ./cp/src/core/__pycache__
	rm -rf ./cp/src/core/v2/api
	rm -rf ./cp/src/core/v2/inst
	rm -rf ./cp/src/core/v2/scripts
	cp ./cp/.env ./cp/src/core/v2/cp/.env
	@echo "✅  <make cp-copy> done."

cp-build: cp-copy
	@if [ -z "$(ver)" ]; then \
		echo "Error: 必須指定 IMAGE VERSION，ex: make cp-build ver=v1"; \
		exit 1; \
	fi
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

cp-push:
	@echo "* Run"
	@if [ -z "$(image)" ]; then \
		echo "Error: 必須指定 VERSION，ex: make cp-push image=??? registry=???"; \
		exit 1; \
	fi
	@if [ -z "$(registry)" ]; then \
		echo "Error: 必須指定 VERSION，ex: make cp-push image=??? registry=???"; \
		exit 1; \
	fi
	docker tag pg-python-cp:$(image) $(REGISTRY_HOST)/pg-python-cp:$(registry)
	docker push $(REGISTRY_HOST)/pg-python-cp:$(registry)

	curl http://$(REGISTRY_HOST)/v2/pg-python-cp/tags/list
	skopeo inspect --tls-verify=false docker://$(REGISTRY_HOST)/pg-python-cp:$(registry) | jq '{Created, Architecture, RepoTags}'

	@echo "✅  <make cp-push image=$(image) registry=$(registry)> done."

cp-status:
	@if [ -z "$(registry)" ]; then \
		echo "Error: 必須指定 VERSION，ex: make cp-status registry=???"; \
		exit 1; \
	fi
	curl http://$(REGISTRY_HOST)/v2/pg-python-cp/tags/list
	skopeo inspect --tls-verify=false docker://$(REGISTRY_HOST)/pg-python-cp:$(registry) | jq '{Created, Architecture, RepoTags}'
	@echo "✅  <make cp-status registry=$(registry)> done."