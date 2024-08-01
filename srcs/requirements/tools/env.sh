#!/bin/bash

echo "Enviroment Generator!!!"

env_exist=$(find ./srcs -maxdepth 1 -name ".env" | wc -l) 

if [ "$env_exist" == 1 ]; then 
	echo "enviroment found" 
	bash ./srcs/requirements/tools/check_env.sh
else 
	echo "no enviroment" 
	bash ./srcs/requirements/tools/generate_env.sh
fi
