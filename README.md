<a href='https://github.com/Junwu0615/Platform Genesis'><img alt='GitHub Views' src='https://views.whatilearened.today/views/github/Junwu0615/Platform Genesis.svg'>

## *⭐ PG-Edge-Container ⭐*

<br>

### *A.　Implement*

<details>
<summary><b><i>　Tree </i></b></summary>
<ul>

```bash
tree -I 'venv|.git|__pycache__|docs|logs|assets|kafka_data|charts'

.
├── LICENSE
├── Makefile
├── README.md
├── cp
│   ├── Dockerfile
│   ├── data
│   └── src ( copy `PG-APP-Core` )
└── inst
    ├── Dockerfile
    ├── data
    │   └── kafka_consumer_local.db
    └── src ( copy `PG-APP-Core` )
```

</ul>
</details>

<br>

### *B.　Command Platform*
```
# local test
make cp-copy
make cp-build ver=v1
make cp-run ver=v1
make cp-logs name=pg-python-cp
make cp-clear name=pg-python-cp
make cp-bash name=pg-python-cp

# registry tset
make cp-status registry=v2 REGISTRY_HOST=127.0.0.1:5100
make cp-status registry=v2 REGISTRY_HOST=docker-registry.k8s.local

make cp-push image=v1 registry=v2 REGISTRY_HOST=127.0.0.1:5100
make cp-push image=v1 registry=v2 REGISTRY_HOST=docker-registry.k8s.local
```

<br>

### *C.　Instance*
```
# local test
make inst-copy
make inst-build ver=v1
make inst-run ver=v1
make inst-logs name=pg-python-edge-01
make inst-clear name=pg-python-edge-01
make inst-bash name=pg-python-edge-01

# registry tset
make inst-status registry=v2 REGISTRY_HOST=127.0.0.1:5100
make inst-status registry=v6 REGISTRY_HOST=docker-registry.k8s.local

make inst-push image=v1 registry=v2 REGISTRY_HOST=127.0.0.1:5100
make inst-push image=v1 registry=v2 REGISTRY_HOST=docker-registry.k8s.local
```

<br><br><br>
