# GLPI deploy with Docker

Deploy and run GLPI (version >= 9.2) with Docker.
Based on https://github.com/driket/docker-glpi

Install latest version by default but you can specify the version you want by passing

You can:
- link to an existing database.
- or create a new one easily with docker-compose.

## Build image

```bash
docker build -t glpi .
```

## Deploy GLPI only (no database)

```bash
docker run -it -d -p 80:80 glpi
```

## Deploy with docker-compose

```bash
docker-compose up -d
```

### docker-compose.yml

```yml
version: '2'
services:
  glpi:
    image: glpi
    ports:
      - "8090:80"
    links:
      - mysql:db
    env_file:
      - ./glpi.env
    volumes:
      - glpidata:/var/www/html/glpi
  mysql:
    image: mariadb
    env_file:
      - ./glpi.env
    volumes:
      - mysqldata:/var/lib/mysql

volumes:
  glpidata:
  mysqldata:
```

### glpi.env

```env
MYSQL_ROOT_PASSWORD=rootpasswd
MYSQL_DATABASE=glpi
MYSQL_USER=glpi
MYSQL_PASSWORD=glpipaswd
GLPI_SOURCE_URL=https://github.com/glpi-project/glpi/releases/download/9.2/glpi-9.2.tgz
```

### Run docker-compose

```bash
docker-compose up -d
```

### Configure new database

Open http://localhost:8090/ for setup first

