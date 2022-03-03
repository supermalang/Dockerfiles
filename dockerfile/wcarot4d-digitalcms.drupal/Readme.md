To build 
```bash
# You can use an environment variable to specify the tag version
export DIGITALCMS_APP_VERSION=main

docker build -t supermalang/digitalcms-stack:${DIGITALCMS_APP_VERSION} -t supermalang/digitalcms-stack:latest --build-arg DIGITALCMS_APP_VERSION=${DIGITALCMS_APP_VERSION} .
```