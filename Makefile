PROJECT_NAME := fiction
IMAGE_ENGINE := docker
COMPOSE := $(IMAGE_ENGINE) compose -p $(PROJECT_NAME)
EXEC := $(COMPOSE) exec

.PHONY: _prerequisites

_prerequisites:
	@for cmd in docker git; do \
		if ! command -v $$cmd &> /dev/null; then \
			echo "[ERROR] $$cmd is not installed. Please install it."; \
			exit 1; \
		fi; \
	done

setup: _prerequisites
	@echo "[SETUP] Downloading and updating backend."
	@git submodule update
	@(cd backend && git checkout main)
	@echo "[OK] Submodule updated successfully."

init: setup

venv:
	@echo "[UPDATE] Updating local venv."
	@(cd backend && uv venv && uv pip install .[dev])
	@echo "[UPDATE] Update completed successfully."
	 
build:
	@echo "[BUILD] Building Docker..."
	@$(COMPOSE) up -d --build
	@echo "[OK] Build completed successfully."

up:
	@echo "[BUILD] Building Docker..."
	@$(COMPOSE) up -d
	@echo "[OK] Build completed successfully."

down:
	@echo "[DOWN] Stopping Docker..."
	@$(COMPOSE) down
	@echo "[OK] Docker stopped successfully."

requirements:
	@echo "[REQUIREMENTS] Installing requirements..."
	@$(EXEC) backend pip install .[dev]
	@echo "[OK] Requirements installed successfully."
