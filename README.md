### Reproducer for https://github.com/php/php-src/issues/7817

1. Build PHP 8.1.10 debug image

```sh
docker build -t php:8.1.10-debug .
```

2. Run in one terminal

```sh
docker run --rm -it -v "$(pwd)":/var/www --mount type=tmpfs,destination=/var/www/var,tmpfs-size=2000M -w /var/www --name jit-test php:8.1.10-debug gdb --args /usr/src/php/sapi/cli/php -S 127.0.0.1:8080 -t public public/index.php
run
```
or without tmpfs for cache folder:
```sh
docker run --rm -it -v "$(pwd)":/var/www -w /var/www --name jit-test php:8.1.10-debug gdb --args /usr/src/php/sapi/cli/php -S 127.0.0.1:8080 -t public public/index.php
run
```

3. Run in another terminal

```sh
docker exec -it jit-test sh test.sh
```

4. Wait for ~5 minutes or ~2000 requests

5. Crash should happen in terminal with gdb

6. Opcache stats dumps before each request can be found in docker container /tmp folder

```sh
docker exec -it jit-test ls /tmp
```
