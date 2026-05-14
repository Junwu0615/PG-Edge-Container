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
# Before Build
cp ../PG-APP-Core/src ./cp/src
rm -r ./cp/src/scripts
rm -r ./cp/src/core/v1
cp ./cp/.env ./cp/src/core/v2/cp/.env

# Build
docker build -t pg-python-cp:v1 -f ./cp/Dockerfile . --no-cache

# Run
docker run -d \
  --name pg-python-cp \
  --env-file ./cp/.env \
  --add-host host.docker.internal:host-gateway \
  pg-python-cp:v1
```

<br>

### *C.　Instance*
```
# Before Build
cp ../PG-APP-Core/src ./inst/src
rm -r ./inst/src/scripts
rm -r ./inst/src/core/v1
cp ./inst/.env ./inst/src/core/v2/inst/.env

# Build
docker build -t pg-python-inst:v1 -f ./inst/Dockerfile . --no-cache

# Run
docker run -d \
  --name pg-python-edge-01 \
  --env-file ./inst/.env \
  --add-host host.docker.internal:host-gateway \
  pg-python-inst:v1
```

<br><br><br>