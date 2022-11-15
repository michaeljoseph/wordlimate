build:
    docker build -t wordlimate .

test:
    poetry run pytest

lint:
    poetry run pre-commit run --all

fix:
    poetry run black src tests
    poetry run isort src tests