#!/bin/bash

DIR="./certificates"

mkdir -p "${DIR}"

openssl req -x509 -nodes -keyout "${DIR}/ca.key" -out "${DIR}/ca.pem" -days 365 -subj "/C=DE/ST=State/L=City/O=Company/OU=Unit/CN=Testcluster Root CA"

for node in 1 2 3; do
    mkdir "${DIR}/keeper${node}"
    cp "${DIR}/ca.pem" "${DIR}/keeper${node}/ca.pem"

    subject="/C=DE/ST=State/L=City/O=Company/OU=Unit/CN=clickhouse-keeper${node}"
    openssl req -x509 -CA "${DIR}/ca.pem" -CAkey "${DIR}/ca.key" -keyout "${DIR}/keeper${node}/keeper.key" -out "${DIR}/keeper${node}/keeper.crt" \
    -days 3650 -nodes -subj "$subject"

    openssl verify -CAfile "${DIR}/ca.pem" "${DIR}/keeper${node}/keeper.crt"
done