# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: samusanc <samusanc@student.42madrid>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/06/24 19:28:25 by samusanc          #+#    #+#              #
#    Updated: 2024/07/25 18:27:47 by samusanc         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all: compose

compose:
	docker compose -f ./srcs/docker-compose.yml up --build	# rebuild the docker image
	docker image prune -f					# delete intermediate images

stop:
	if [ -n "$$(docker ps -aq)" ]; then \
		docker stop $$(docker ps -aq); \
	fi
	#docker stop $$(docker ps -aq)				# stop all containers

bash_nginx:

re: fclean all

fclean: clean
	#docker system prune -a -f
	#aqui va la regla ara destruir todos los volumenes?

clean: stop
	if [ -n "$$(docker ps -aq)" ]; then \
		docker rm $$(docker ps -aq); \
	fi

.PHONY: all clean fclean re stop compose
