# Web Server

(View On Github)[https://github.com/samerior/laravel-docker]
Nginx & PHP 7 web server.

## Build 

This includes:
 - PHP 7.4
 - NGINX 1.17
 - Supervisord 
 - Composer

## Tags

### latest
 This tag contains base webserver with no cron setups for queues or horizon

### horizon
 This tag contains supervisor configuration for horizon

### queues
This tag contains supervisor configuration for the default queues

# Laravel Application - Quick Run

Using the Laravel installer you can get up and running with a Laravel application inside Docker in minutes.

- Create a new Laravel application `$ laravel new app`
- Change to the applications directory `$ cd app`
- Start the container and attach the application. `$ docker run -d -p 8080:80 --name=testapp -v $PWD:/var/www samerior/laravel-webserver`
- Visit the Docker container URL like [http://0.0.0.0:8080](http://0.0.0.0:8080). 

### Args

Here are some args

- `NGINX_HTTP_PORT` - HTTP port. Default: `80`.
- `NGINX_HTTPS_PORT` - HTTPS port. Default: `443`.
- `PHP_VERSION` - The PHP version to install. Supports: `7.4,7.3,7.2,7.1`. Default: `7.2`.
- `ALPINE_VERSION` - The Alpine version. Supports: `3.10`. Default: `3.10`.

### Environment Variables

Here are some configurable environment values.

- `WEBROOT` – Path to the web root. Default: `/var/www`
- `WEBROOT_PUBLIC` – Path to the web root. Default: `/var/www/public`
- `COMPOSER_DIRECTORY` - Path to the `composer.json` containing directory. Default: `/var/www`.
- `COMPOSER_UPDATE_ON_BUILD` - Should `composer update` run on build. Default: `0`.
- `RUN_LARAVEL_SCHEDULER` - Should the Laravel scheduler command run. Default: `0`.
- `RUN_LARAVEL_MIGRATIONS_ON_BUILD` - Should the migrate command run during build. Default: `0`.
- `PRODUCTION` – Is this a production environment. Default: `0`
- `PHP_MEMORY_LIMIT` - PHP memory limit. Default: `128M`
- `PHP_POST_MAX_SIZE` - Maximum POST size. Default: `50M`
- `PHP_UPLOAD_MAX_FILESIZE` - Maximum file upload file. Default: `10M`.
