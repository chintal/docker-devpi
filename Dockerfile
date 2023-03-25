FROM python:3.11-alpine


RUN apk add --no-cache --virtual .build-deps gcc musl-dev libffi-dev
RUN pip install devpi-server devpi-web
WORKDIR /root
VOLUME /devpi
COPY docker-entrypoint.sh /docker-entrypoint.sh
EXPOSE 3141
ARG DEVPI_PATH
ENV DEVPI_PATH="/devpi"
ENV DEVPI_ROOT_PASSWORD=
ENTRYPOINT ["sh", "/docker-entrypoint.sh"]
CMD ["devpi-server", \
     "--host", "0.0.0.0", \
     "--offline-mode", \
     "--secretfile", "/devpi/secrets/secret",\
     "--serverdir", "/devpi/server"]
