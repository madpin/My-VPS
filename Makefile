.PHONY: help
.DEFAULT_GOAL := help

SHELL := /bin/bash

all_down: ## Turn off all running dockers
	source bash/bash_func.sh && all_down

all_up: ## Turn ON all running dockers (and start scrobbler)
	source bash/bash_func.sh && all_up

upgrade: ## Upgrade and turn ON all running dockers (and start scrobbler)
	source bash/bash_func.sh && docker_pulls
	source bash/bash_func.sh && all_up
	source bash/bash_func.sh && docker_image_prune

scrob_sync: ## Sync the watch from plex with Track, all at once
	source bash/bash_func.sh && scrob_sync
scrob_watch: ## Keep an eye to what you're watching now.
	source bash/bash_func.sh && scrob_watch
scrob_relogin: ## Re-login and plex force relogin
	source bash/bash_func.sh && scrob_relogin

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
