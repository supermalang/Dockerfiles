# app.xayma.sh

Docker file to deploy a container with the ***[Xayma App](https://github.com/supermalang/app.xayma.sh)*** web application.  


To build on Linux CLI

```bash
# You can use an environment variable to specify the tag version
export XAYMA_APP_VERSION=0.9.41

docker build -t supermalang/xaymash-app:${XAYMA_APP_VERSION} -t supermalang/xaymash-app:latest --build-arg XAYMA_APP_VERSION=${XAYMA_APP_VERSION} .
```
 