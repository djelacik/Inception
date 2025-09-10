# Inception

A professional Docker-based infrastructure project for system administration and DevOps reference.

## Project Overview

This repository demonstrates a secure, production-like multi-container setup using Docker Compose. The stack includes:
- **NGINX** (TLSv1.2/1.3 only, HTTPS on port 443)
- **WordPress** (with PHP-FPM)
- **MariaDB** (database)

All services run in dedicated containers, communicate over a custom Docker network, and persist data using volumes.

## Directory Structure

```
Inception/
├── Makefile
├── secrets/           # Credentials and passwords (excluded from git)
├── srcs/
│   ├── docker-compose.yml
│   └── requirements/
│       ├── mariadb/
│       ├── nginx/
│       └── wordpress/
└── .gitignore
```

## Quick Start

1. **Clone the repository:**
   ```bash
   git clone git@github.com:djelacik/Inception.git
   cd Inception
   ```

2. **Add your domain to `/etc/hosts`:**
   ```bash
   echo "127.0.0.1 yourdomain.local" | sudo tee -a /etc/hosts
   ```

3. **Create persistent data directories:**
   ```bash
   sudo mkdir -p /home/$(whoami)/data/{wordpress,mariadb}
   sudo chown -R $(whoami):$(whoami) /home/$(whoami)/data
   ```

4. **Configure environment variables and secrets:**
   - Copy sample `.env` and secrets files (not included in git) and fill in your values.
   - Do **not** commit these files to git.

5. **Build and start the stack:**
   ```bash
   make
   ```

6. **Access your site:**
   - https://yourdomain.local

## Makefile Commands

- `make` / `make build` — Build and start all containers
- `make up` — Start containers
- `make down` — Stop containers
- `make restart` — Restart containers
- `make clean` — Remove containers and images
- `make fclean` — Remove containers, images, and persistent data
- `make logs` — View container logs

## Security & Best Practices

- All credentials and secrets are stored outside the repository
- No passwords in Dockerfiles or version control
- TLS enforced (HTTPS only)
- Containers restart automatically on failure
- No host networking, legacy links, or insecure hacks
- Volumes for persistent data
- Environment variables for configuration

## Technologies Used

- Docker & Docker Compose
- NGINX (Debian/Alpine based)
- WordPress & PHP-FPM
- MariaDB
- Bash scripting

## Usage as a Reference

This project is designed as a professional example for:
- DevOps and system administration interviews
- Demonstrating Docker Compose orchestration
- Secure multi-service infrastructure setup
- Custom container builds and automation

Feel free to fork, adapt, and use as a template for your own projects.

## License

This project is licensed under the MIT License.

---

