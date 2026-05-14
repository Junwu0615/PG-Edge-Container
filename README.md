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
└── README.md
```

</ul>
</details>

<br>

### *B.　Command Platform*
```
cd ..
docker build -t pg-python-cp:v1 -f ./PG-Edge-Container/cp/Dockerfile . --no-cache

docker run -d \
  --name pg-python-cp \
  --env-file ./cp/.env \
  --add-host host.docker.internal:host-gateway \
  pg-python-cp:v1
```

<br>

### *C.　Instance*
```
cd ..
docker build -t pg-python-inst:v1 -f ./PG-Edge-Container/inst/Dockerfile . --no-cache

docker run -d \
  --name pg-python-edge-01 \
  --env-file ./PG-Edge-Container/inst/.env \
  --add-host host.docker.internal:host-gateway \
  pg-python-inst:v1
```

<br><br><br>