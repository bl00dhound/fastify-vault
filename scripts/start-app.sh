#!/bin/bash

if [[ -f /vault/secrets/database-config ]]; then
  echo "Consume vault db variables"
  while read line; do
    export $line
  done < /vault/secrets/database-config
fi

fastify start -l info ./svc/app.js
