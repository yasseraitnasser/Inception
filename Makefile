NAME = inception
USER = yasseroo
COMPOSE_FILE = srcs/docker-compose.yml
DB_VOLUME_PATH = /home/$(USER)/data/mariadb
WP_VOLUME_PATH = /home/$(USER)/data/wordpress

# --- Targets ---

up:
	mkdir -p $(DB_VOLUME_PATH)
	mkdir -p $(WP_VOLUME_PATH)
	docker compose -f $(COMPOSE_FILE) -p $(NAME) up -d --build

down:
	docker compose -f $(COMPOSE_FILE) -p $(NAME) down

clean:
	docker compose -f $(COMPOSE_FILE) -p $(NAME) down -v
	docker system prune -f

fclean: clean
	rm -rf $(DB_VOLUME_PATH) $(WP_VOLUME_PATH)
	docker system prune -af --volumes

re: fclean up

