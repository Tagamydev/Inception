# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: samusanc <samusanc@student.42madrid>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/06/24 19:28:25 by samusanc          #+#    #+#              #
#    Updated: 2024/07/27 14:11:17 by samusanc         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all: build up

build:								# build the docker image
	docker-compose -f ./srcs/docker-compose.yml build	
	docker image prune -f					# delete intermediate images

up:								# up the docker image and rebuilding if it is nescessary
	docker-compose -f ./srcs/docker-compose.yml up --build	

down:								# down the docker image
	docker-compose -f ./srcs/docker-compose.yml down	

stop:								# stop all containers
	if [ -n "$$(docker ps -aq)" ]; then \
		docker stop $$(docker ps -aq); \
	fi

re: fclean all

fclean: down clean
	docker system prune -a -f
	#aqui va la regla ara destruir todos los volumenes?

clean: stop
	if [ -n "$$(docker ps -aq)" ]; then \
		docker rm $$(docker ps -aq); \
	fi

.PHONY: all clean fclean re stop down up build
