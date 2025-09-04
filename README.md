# Laravel Vue Docker

This repository contains a Dockerized Laravel application with a Vue frontend.

## Services

- **nginx** – serves the application over HTTP
- **app** – PHP-FPM container running the Laravel code
- **db** – MariaDB database
- **redis** – cache and queue backend

## Getting Started

1. Copy environment variables and adjust if needed:
   ```bash
   cp app/.env.example app/.env
   ```
2. Build and start the containers (installs dependencies and builds assets):
   ```bash
   docker-compose up --build -d
   ```
3. Run database migrations and seed test users:
   ```bash
   docker-compose exec app php artisan migrate --seed
   ```

4. Visit the application at [http://localhost](http://localhost) (use `NGINX_WEB_PORT` to change the port, default `80`).

The default database credentials are defined in `app/.env.example` and match the values in `docker-compose.yml`.

## Development

The Docker build installs PHP (Composer) and Node dependencies, and the container entrypoint compiles frontend assets. No manual `npm install` or `npm run build` is required.

### Common tasks

Use `docker-compose exec app` to run commands inside the application container:

- **Run migrations**: `docker-compose exec app php artisan migrate` (add `--seed` if needed)
- **Rebuild frontend assets**: `docker-compose exec app npm run build`
- **Other Artisan/Node commands**: `docker-compose exec app php artisan <command>` or `docker-compose exec app npm run <script>`

