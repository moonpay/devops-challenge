#!/bin/sh
set -e

case "$1" in
  migrate)
    export NODE_PATH=/prisma-cli/node_modules
    exec /prisma-cli/node_modules/.bin/prisma migrate deploy --schema ./prisma/schema.prisma
    ;;
  start|*)
    exec node server.js
    ;;
esac
