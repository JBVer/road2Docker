all: up

up:
	mkdir -p /home/jvermeer/data/mariadb
	mkdir -p /home/jvermeer/data/wordpress
	docker compose -f srcs/docker-compose.yml --env-file srcs/.env up -d --build

down:
	docker compose -f srcs/docker-compose.yml down

clean: down
	docker system prune -af

volume: clean
	docker volume rm srcs_database
	docker volume rm srcs_wp_files
	sudo rm -rf /home/jvermeer/data/mariadb
	sudo rm -rf /home/jvermeer/data/wordpress

.PHONY: all up down clean volume
