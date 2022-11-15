# https://www.mktr.ai/the-data-scientists-quick-guide-to-dockerfiles-with-examples/
# https://fastapi.tiangolo.com/deployment/docker/?h=cache#docker-image-with-poetry
FROM python:3.11-slim as build

ENV POETRY_VERSION=1.2.1 \
    POETRY_HOME="/opt/poetry" \
    POETRY_VIRTUALENVS_IN_PROJECT=true \
    POETRY_NO_INTERACTION=1 \
    PYSETUP_PATH="/opt/pysetup" \
    VENV_PATH="/opt/pysetup/.venv" \
    PATH="$POETRY_HOME/bin:$VENV_PATH/bin:$PATH"

RUN python -m pip install "poetry==$POETRY_VERSION"

COPY pyproject.toml poetry.lock ./

RUN poetry export -f requirements.txt --output /tmp/requirements.txt --without-hashes

FROM python:3.11-slim

WORKDIR /code

COPY --from=build /tmp/requirements.txt .

RUN pip install --no-cache-dir --upgrade -r requirements.txt

COPY src ./

CMD ["uvicorn", "wordlimate.api:app", "--host", "0.0.0.0", "--port", "80"]
