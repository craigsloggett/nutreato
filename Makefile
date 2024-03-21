# Variables
VENV_NAME = .venv
PYTHON := ${VENV_NAME}/bin/python
PYTHON_VERSION := $(shell python3 --version | cut -d ' ' -f 2)

# Setup the virtual environment and install dependencies
setup:
	python3 -m venv --prompt $(PYTHON_VERSION) $(VENV_NAME)
	$(PYTHON) -m pip install -r requirements.txt
	@echo ""
	@echo "Activate the virtual environment with:"
	@echo "source .venv/bin/activate"

# Run the Django development server
run:
	$(PYTHON) DietDiary/manage.py runserver

# Lint with ruff
lint:
	ruff check --output-format "full"
	ruff check --select I --output-format "full"

# Format code with ruff
format:
	ruff check --select I --fix --show-fixes
	ruff format --diff

# Delete Python file artifacts
clean:
	find . -type f -name '*.pyc' -delete
	find . -type f -name '*.pyo' -delete
	find . -type f -name '*~' -delete
	find . -type d -name '__pycache__' -delete

.PHONY: setup run lint format clean
