# php-docker

php-docker is a simple docker-compose orchestration that sets up a three-
container network for local PHP development (Laravel, Symfony, Slim, etc).
With this repo, you get:

- PHP container
    - Builds custom from php:7.4-fpm-alpine
    - Adds a bunch* of PHP extensions
    - Installs curl, vim, and composer for convenience
    - Maps ./src to /var/www
    - Uses PHP-FPM running on :9000
- Nginx container
    - Uses nginx:latest
    - Supports use of [mkcert](https://mkcert.dev) for local SSL (see SSL below)
    - Listens on port 80 (for convenience)
- Mariadb container
    - Uses mariadb:latest
    - Stores data in ./mariadb/
    - Inits from vars in docker-compose.yml

_* see Dockerfile_

# Usage

1. [Install Docker CE](https://docs.docker.com/install/#supported-platforms)

2. [Install Docker Compose](https://docs.docker.com/compose/install/)

3. Clone this repository

```bash
git clone https://github.com/mccheesy/php-docker.git`
```

4. Either copy your existing PHP application source to the `src` directory or
   create a new project. Since you have Docker installed, you can create a new
   Laravel project using the Composer container thus:

```bash
docker run --rm --it \
    --volume $PWD:/app \
    --user $(id -u):$(id -g) \
    composer create-project --prefer-dist laravel/laravel src
```

5. Build and run the containers (in detached mode)
```bash
docker-compose up -d
```

# For SSL [Optional]

1. [Install mkcert](https://mkcert.dev)

2. Create cert files for [https://app.test](https://app.test). For example:
```bash
mkcert -install
mkcert app.test "*.app.test"
mv *.pem ./nginx/ssl/
```

3. Edit line 50 of docker-compose.yml: change server.conf to server-ssl.conf

4. Rebuild the Nginx container
```bash
docker-compose up -d --build nginx
```

# Hosts

If you are used to something like
[Valet](https://laravel.com/docs/master/valet), this can be a little tedious. I
just use the same test domain (app.test) for all my sites and keep only one of
these container networks running at a time.

If you have a need to add multiple subdomains or domains, you will just need to
adjust your hosts file and the Nginx/docker-compose files and rebuild the
containers.

# Contact

I do not claim to be an expert on Docker, Docker Compose, or container
orchestration, but if you have any questions or run into any issues, I'm happy
to offer whatever help I can supply. I can be reached via email at
[jmccleese@gmail.com](mailto:jmccleese@gmail.com?subject=php-docker).