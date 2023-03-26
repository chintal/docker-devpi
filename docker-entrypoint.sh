#!/bin/sh

if ! [ -d $DEVPI_PATH/server ]; then
	echo "First Run. Initializing devpi."
	devpi-init --no-root-pypi \
		--role standalone \
		--root-passwd $DEVPI_ROOT_PASSWORD \
		--serverdir $DEVPI_PATH/server
fi

if ! [ -f $DEVPI_PATH/secrets/secret ]; then
	echo "Generating a devpi secret"
	mkdir $DEVPI_PATH/secrets
	devpi-gen-secret --secretfile $DEVPI_PATH/secrets/secret
	chmod g-w $DEVPI_PATH/secrets
fi

exec "$@"
