# Keeper Rolling Upgrade

## Requirements

Docker installation

## Steps to reproduce

* `docker-compose up -d`
* `docker logs clickhouse-keeper3`
* search for `Error`, like `<Error> RaftInstance: CRC mismatch: local calculation`