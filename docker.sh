#!/bin/bash


# Nodejs package command
CMD_NPM="npm"
CMD_YARN="yarn"

# JS
CMD_JS_CONTAINER_SHELL="js-container-console"
CMD_JS_RUN="js-run"

# Koa.js
CMD_KOA_RUN="run-koa"

# Service
CMD_SERVICE_MANGODB="run-mangodb"
CMD_SERVICE_LOCALSTACK="run-localstack"
CMD_SERVICE_LOCALSTACK_CONSOLE="console-localstack"
CMD_SERVICE_MYSQL="run-mysql"

# https://stackoverflow.com/questions/5474732/how-can-i-add-a-help-method-to-a-shell-script
usage="
\033[1m$(basename "$0")\033[0m - JS

Options:
    -h      show detail description about how to use options and commands.

Commands:
    Services:
       \033[1m"$CMD_SERVICE_MANGODB"\033[0m 
            Run MangoDB server
       \033[1m"$CMD_SERVICE_LOCALSTACK"\033[0m 
            Run Localstack server
       \033[1m"$CMD_SERVICE_LOCALSTACK_CONSOLE"\033[0m 
            Localstack console
       \033[1m"$CMD_SERVICE_MYSQL"\033[0m 
            Run MySQL server
       
    NPM:
       \033[1m"$CMD_NPM"\033[0m
            Run npm command
       \033[1m"$CMD_YARN"\033[0m
            Run yarn command
    JS:
       \033[1m"$CMD_JS_CONTAINER_SHELL"\033[0m 
            Console of JS App container

    Koa.js:
       \033[1m"$CMD_KOA_RUN"\033[0m 
            Run Koa.js App container
"

seed=42
while getopts ':hs:' option; do
    case "$option" in
    h)
        echo -e "$usage"
        exit
        ;;
    s)
        seed=$OPTARG
        ;;
    :)
        printf "missing argument for -%s\n" "$OPTARG" >&2
        echo "$usage" >&2
        exit 1
        ;;
    \?)
        printf "illegal option: -%s\n" "$OPTARG" >&2
        echo "$usage" >&2
        exit 1
        ;;
    esac
done
shift $((OPTIND - 1))

PROJECT_NAME_JS='js-dev'
DOCKER_FILE="docker-compose.local.yml"
CMD_DOCKER=" docker-compose -f $DOCKER_FILE "
CMD_DOCKER_JS_PROJ_RUN=" $CMD_DOCKER run $PROJECT_NAME_JS"

Command="$1"
ARGUMENTS="$2"
$CMD_DOCKER build
if [ "$CMD_NPM" == "$Command" ]; then
    $CMD_DOCKER_JS_PROJ_RUN $Command $ARGUMENTS
elif [ "$CMD_YARN" == "$Command" ]; then
    $CMD_DOCKER_JS_PROJ_RUN $Command $ARGUMENTS
elif [ "$CMD_JS_CONTAINER_SHELL" == "$Command" ]; then
    $CMD_DOCKER_JS_PROJ_RUN sh
elif [ "$CMD_JS_RUN" == "$Command" ]; then
    $CMD_DOCKER up 
elif [ "$CMD_KOA_RUN" == "$Command" ]; then
    $CMD_DOCKER up koa-app
elif [ "$CMD_SERVICE_MANGODB" == "$Command" ]; then
    $CMD_DOCKER up mongodb
elif [ "$CMD_SERVICE_LOCALSTACK" == "$Command" ]; then
    $CMD_DOCKER up localstack
elif [ "$CMD_SERVICE_LOCALSTACK_CONSOLE" == "$Command" ]; then
    $CMD_DOCKER exec localstack sh
elif [ "$CMD_SERVICE_MYSQL" == "$Command" ]; then
    $CMD_DOCKER up db
fi

