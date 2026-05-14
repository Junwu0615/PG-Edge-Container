<a href='https://github.com/Junwu0615/Platform Genesis'><img alt='GitHub Views' src='https://views.whatilearened.today/views/github/Junwu0615/Platform Genesis.svg'>

## *⭐ PG-Edge-Container ⭐*

<br>

### *A.　Roadmap*

<details>
<summary><b><i>　Project Tree </i></b></summary>
<ul>

```bash
tree -I 'venv|.git|__pycache__|docs|logs|assets|kafka_data'
tree -d -I 'venv|.git|__pycache__|docs|logs|assets|kafka_data'

.
├── Makefile
├── README.md
├── cp
│   ├── Dockerfile
│   ├── data
│   └── src
│       ├── __init__.py
│       └── core
│           ├── __init__.py
│           ├── models
│           │   ├── __init__.py
│           │   ├── simulator.py
│           │   └── sink_format.py
│           └── v2
│               ├── __init__.py
│               ├── api
│               │   └── __init__.py
│               ├── cp
│               │   ├── __init__.py
│               │   └── main.py
│               ├── factory_config.yaml
│               ├── inst
│               │   ├── __init__.py
│               │   └── main.py
│               └── scripts
│                   ├── __init__.py
│                   ├── create_topic.py
│                   ├── init.py
│                   └── topics_config.json
└── inst
    ├── Dockerfile
    ├── data
    │   └── kafka_consumer_local.db
    └── src
        ├── __init__.py
        └── core
            ├── __init__.py
            ├── models
            │   ├── __init__.py
            │   ├── simulator.py
            │   └── sink_format.py
            └── v2
                ├── __init__.py
                ├── api
                │   └── __init__.py
                ├── cp
                │   ├── __init__.py
                │   └── main.py
                ├── factory_config.yaml
                ├── inst
                │   ├── __init__.py
                │   └── main.py
                └── scripts
                    ├── __init__.py
                    ├── create_topic.py
                    ├── init.py
                    └── topics_config.json
```

</ul>
</details>

<br>

### *B.　Command Platform*
```
make cp-build ver=v1
make cp-run ver=v1
make cp-logs name=pg-python-cp
make cp-clear name=pg-python-cp
make cp-bash name=pg-python-cp
```

<br>

### *C.　Instance*
```
make inst-build ver=v1
make inst-run ver=v1
make inst-logs name=pg-python-edge-01
make inst-clear name=pg-python-edge-01
make inst-bash name=pg-python-edge-01
```

<br><br><br>
