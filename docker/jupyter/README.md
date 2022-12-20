
## To run this beauty:

docker tag local-image:tagname new-repo:tagname
docker push new-repo:tagname

docker build -t madpin/jupyter:latest docker/jupyter
docker push madpin/jupyter:latest

### To run 'temporarily'
```bash
docker run -it --rm --user root --pull=always -p 8888:8888 \
    -e NB_UID="$(id -u)" -e NB_GID="$(id -g)" \
    -e NB_USER="$USER" \
    -v "${PWD}":/ipynb \
    -v "${HOME}":/ipynb/__home \
    --name jupyter \
    madpin/jupyter:latest
```

### To Install:
```bash
docker run -it -d --pull=always -p 8888:8888 \
    -e NB_UID="$(id -u)" -e NB_GID="$(id -g)" \
    -e NB_USER="$USER" \
    -v "${PWD}":/ipynb \
    -v "${HOME}":/ipynb/__home \
    --restart=unless-stopped \
    --name jupyter \
    madpin/jupyter:latest
```
### To Update:
```bash
docker pull madpin/jupyter:latest
```

### To Start:
It should not stop, and even after restarting, it will start again 😁
```bash
docker start jupyter
```

### To stop:
But if even so, you really want to stop 🛑 it:
```bash
docker stop jupyter && docker rm jupyter
```

### To 'Uninstall':
```bash
docker stop jupyter && docker rm jupyter
```


```
docker run --privileged --rm tonistiigi/binfmt --install all
docker buildx create --use

docker buildx build \
    --platform linux/amd64,linux/arm64 \
    -t madpin/jupyter:latest \
    -t madpin/jupyter:$(date +'%Y%m%d') \
    -t madpin/jupyter:$(date +'%Y%m%d-%H%M') \
    --push docker/jupyter



```