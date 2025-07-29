# Inception Project

This project implements a multi-container Docker infrastructure with:
- NGINX with TLS (only TLSv1.2/TLSv1.3)
- WordPress + PHP-FPM
- MariaDB

## Requirements
- Docker
- Docker Compose
- Make

## Setup

1. Clone the repository
2. Update the domain name in `srcs/.env` to match your login
3. Add domain to your hosts file:
   ```
   echo "127.0.0.1 yourdomain.42.fr" | sudo tee -a /etc/hosts
   ```
4. Build and run:
   ```
   make
   ```

## Important Notes

### For School Evaluation
Before submitting or evaluating at school:
1. Remove the `.env` file from git tracking
2. Create data directories manually on the evaluation machine
3. Update domain name and paths as needed

### Environment Variables
The `.env` file contains development credentials. For production/evaluation:
- Use Docker secrets properly
- Never commit real credentials to git
- Update paths to match the evaluation environment

## Commands

- `make` or `make build` - Build and start all containers
- `make up` - Start existing containers
- `make down` - Stop containers
- `make restart` - Restart all containers  
- `make clean` - Remove containers and images
- `make fclean` - Remove everything including volumes
- `make logs` - View container logs

## Architecture

```
Internet -> NGINX (443/TLS) -> WordPress (PHP-FPM) -> MariaDB
                |
            WordPress Files Volume
                |
            MariaDB Data Volume
```

## Security Features

- TLS 1.2/1.3 only
- No passwords in Dockerfiles
- Docker secrets for sensitive data
- Non-root containers where possible
- Proper network isolation
