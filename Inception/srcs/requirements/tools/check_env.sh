#!/bin/bash

echo "checking enviroment..." 
env_good=$(echo -n "$(diff ./srcs/requirements/tools/example_env.txt <(cat ./srcs/.env | sed '/^#/d' | tr "=" " " | awk '{print $1}'))" | wc -l)

if [ "$env_good" == 0 ]; then 
	echo "nice enviroment" 
	echo "continue to docker building..."
else 
	echo "fail enviroment check"
	echo "enviroment regenerating..."
	bash ./srcs/requirements/tools/generate_env.sh
fi
