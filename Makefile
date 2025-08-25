# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::   #
#    Makefile                                           :+:      :+:    :+:   #
#                                                     +:+ +:+         +:+     #
#    By: djelacik <djelacik@student.42.fr>          +#+  +:+       +#+        #
#                                                 +#+#+#+#+#+   +#+           #
#    Created: 2025/07/29 00:00:00 by djelacik          #+#    #+#             #
#    Updated: 2025/07/29 00:00:00 by djelacik         ###   ########.fr       #
#                                                                              #
# **************************************************************************** #

DOCKER_COMPOSE_FILE = srcs/docker-compose.yml
VOLUMES_PATH = /home/$(USER)/data

all: build

build:
	@echo "Building Inception project..."
	@mkdir -p $(VOLUMES_PATH)/wordpress
	@mkdir -p $(VOLUMES_PATH)/mariadb
	cd srcs && docker-compose -f docker-compose.yml --env-file .env up --build -d

up:
	@echo "Starting containers..."
	cd srcs && docker-compose -f docker-compose.yml --env-file .env up -d

down:
	@echo "Stopping containers..."
	cd srcs && docker-compose -f docker-compose.yml --env-file .env down

stop:
	@echo "Stopping containers..."
	cd srcs && docker-compose -f docker-compose.yml --env-file .env stop

restart: down up

clean: down
	@echo "Cleaning up containers, images and volumes..."
	docker system prune -af
	docker volume prune -f

fclean: clean
	@echo "Removing data volumes..."
	sudo rm -rf $(VOLUMES_PATH)

re: fclean all

logs:
	cd srcs && docker-compose -f docker-compose.yml --env-file .env logs -f

.PHONY: all build up down stop restart clean fclean re logs
