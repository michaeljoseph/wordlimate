build:
    docker build -t wordlimate .

test:
    poetry run pytest

watch-tests:
    poetry run ptw

lint:
    poetry run pre-commit run --all

fix:
    poetry run black src tests
    poetry run isort src tests

diagrams:
    curl https://kroki.io/nomnoml/svg \
        --data-binary '@docs/classes.nomnoml' \
        -o media/classes.svg

    curl https://kroki.io/seqdiag/svg \
        --data-binary '@docs/sequence.diag' \
        -o media/sequence.svg