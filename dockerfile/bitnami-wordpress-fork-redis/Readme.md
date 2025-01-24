To build 
```bash
# You can use an environment variable to specify the tag version
export WP_VERSION=6.7.1

docker build -t supermalang/bitnami-wordpress-redis:${WP_VERSION} -t supermalang/bitnami-wordpress-redis:latest --build-arg WP_VERSION=${WP_VERSION} .
```