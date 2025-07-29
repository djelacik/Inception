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
	docker-compose -f $(DOCKER_COMPOSE_FILE) up --build -d

up:
	@echo "Starting containers..."
	docker-compose -f $(DOCKER_COMPOSE_FILE) up -d

down:
	@echo "Stopping containers..."
	docker-compose -f $(DOCKER_COMPOSE_FILE) down

stop:
	@echo "Stopping containers..."
	docker-compose -f $(DOCKER_COMPOSE_FILE) stop

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
	docker-compose -f $(DOCKER_COMPOSE_FILE) logs -f

.PHONY: all build up down stop restart clean fclean re logs
