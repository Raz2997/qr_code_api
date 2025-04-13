FROM python:3.12-slim-bullseye
ENV PYTHONUNBUFFERED=1 \
    PYTHONFAULTHANDLER=1 \
    PIP_NO_CACHE_DIR=off \
    PIP_DEFAULT_TIMEOUT=100 \
    PIP_DISABLE_PIP_VERSION_CHECK=on
WORKDIR /myapp
RUN apt-get update \
    && apt-get install -y --no-install-recommends gcc libpq-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
COPY ./requirements.txt /myapp/requirements.txt
RUN pip install --upgrade pip \
    && pip install -r requirements.txt
COPY . /myapp
COPY start.sh /start.sh
RUN chmod +x /start.sh
# Debug: Verify start.sh exists
RUN ls -l /start.sh
RUN useradd -m myuser
USER myuser
EXPOSE 8000
CMD ["/start.sh"]