# **********************  INCEPTION MAKEFILE  ********************** #

.PHONY			:	all up build start stop down ps volumes images prune clean fclean re

# **************************  VARIABLES  *************************** #

# ----------  Directories  ----------- #

DIR_SRCS			=	./srcs/
DIR_DATA			=	/home/bperriol/data/
DIR_DATA_WORDPRESS	=	/home/bperriol/data/wordpress/
DIR_DATA_DATABASE	=	/home/bperriol/data/db/

# ------------  Files  --------------- #

DOCKER_COMPOSE_FILE	=	${addprefix ${DIR_SRCS}, docker-compose.yml}

# ----------  Compilation  ----------- #

DOCKER_COMPOSE	=	docker-compose -f $(DOCKER_COMPOSE_FILE)

# ------------  Commands  ------------ #

MKDIR			=	mkdir -p

RM				=	rm -rf

# ****************************  RULES  ***************************** #

all	:	up

# ---------  Compiled Rules  --------- #

up		:	| $(DIR_DATA_DATABASE) $(DIR_DATA_WORDPRESS)
	@printf "\033[0;33mBuild images, create containers and start them in background\033[0m\n"
	$(DOCKER_COMPOSE) up -d --build

build	:	| $(DIR_DATA_DATABASE) $(DIR_DATA_WORDPRESS)
	@printf "\033[0;33mBuild images from Dockerfiles\033[0m\n"
	$(DOCKER_COMPOSE) build

start	:	| $(DIR_DATA_DATABASE) $(DIR_DATA_WORDPRESS)
	@printf "\033[0;33mStart stopped containers\033[0m\n"
	$(DOCKER_COMPOSE) start

stop	:
	@printf "\033[0;33mStop containers\033[0m\n"
	$(DOCKER_COMPOSE) stop

down	:
	@printf "\033[0;33mStop and remove containers and volumes\033[0m\n"
	$(DOCKER_COMPOSE) down -v

ps		:
	@printf "\033[0;33mList all containers\033[0m\n"
	$(DOCKER_COMPOSE) ps -a

volumes		:
	@printf "\033[0;33mList all volumes\033[0m\n"
	docker volume ls

images		:
	@printf "\033[0;33mList all images\033[0m\n"
	docker images

prune		:
	@printf "\033[0;33mDelete all images\033[0m\n"
	docker system prune -f -a

$(DIR_DATA_DATABASE)	:
	$(MKDIR) $(DIR_DATA_DATABASE)

$(DIR_DATA_WORDPRESS)	:
	$(MKDIR) $(DIR_DATA_WORDPRESS)

# ---------  Usual Commands  --------  #

clean				:
	$(DOCKER_COMPOSE) down -v --rmi all --remove-orphans

fclean				:	clean prune
	sudo $(RM) $(DIR_DATA)

re					:	fclean all
