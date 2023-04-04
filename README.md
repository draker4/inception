# inception
13th project of the 42 school program.
Inception uses docker compose to build three containers, one for wordpress, an other for mariadb, and a last one for nginx. Each container uses its own dockerfile, using only stable debian images and configuring each service inside.
Networks and volumes are created in the docker-compose.yml file too. For the bonus part, a few services are configured: a nodejs server, adminer, a FTP server, redis cache for wordpress and Cadvisor.
