#!/bin/bash

set -e

SSL_DIR="/etc/nginx/ssl"
DOMAIN="lgesite.com"
VALIDITY_DAYS=365

PRIVATE_KEY="${SSL_DIR}/${DOMAIN}.key"
CSR="${SSL_DIR}/${DOMAIN}.csr"
CERTIFICATE="${SSL_DIR}/${DOMAIN}.crt"

echo "Creating SSL directory..."
mkdir -p "$SSL_DIR"

echo "Generating private key..."
openssl genrsa -out "$PRIVATE_KEY" 2048

echo "Generating CSR..."
openssl req -new -key "$PRIVATE_KEY" -out "$CSR" \
  -subj "/C=PH/ST=Bulacan/L=San Jose/O=RhelTek/OU=IT/CN=$DOMAIN/emailAddress=brandonlucasfaye@gmail.com"

echo "Generating certificate..."
openssl x509 -req -days "$VALIDITY_DAYS" -in "$CSR" -signkey "$PRIVATE_KEY" -out "$CERTIFICATE"

echo "Setting permissions..."
chmod 600 "$PRIVATE_KEY"
chmod 644 "$CERTIFICATE"

echo "SSL generation completed:"
echo "Key: $PRIVATE_KEY"
echo "Cert: $CERTIFICATE"