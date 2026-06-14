#!/bin/bash

set -e

SSL_DIR="/etc/nginx/ssl"
DOMAIN="lgesite.com"
VALIDITY_DAYS=365

PRIVATE_KEY="${SSL_DIR}/${DOMAIN}.key"
CSR="${SSL_DIR}/${DOMAIN}.csr"
CERTIFICATE="${SSL_DIR}/${DOMAIN}.crt"
LOG_FILE="/tmp/ssl_generation.log"

log() {
  echo "$(date +"%Y-%m-%d %H:%M:%S") - $1" | tee -a "$LOG_FILE"
}

handle_error() {
  log "ERROR: $1"
  exit 1
}

log "Starting SSL generation for domain: $DOMAIN"

mkdir -p "$SSL_DIR" || handle_error "Failed to create SSL directory."

openssl genrsa -out "$PRIVATE_KEY" 2048 2>>"$LOG_FILE" || handle_error "Failed to generate private key."

openssl req -new -key "$PRIVATE_KEY" -out "$CSR" \
  -subj "/C=PH/ST=Bulacan/L=San Jose/O=RhelTek/OU=IT/CN=$DOMAIN/emailAddress=brandonlucasfaye@gmail.com" \
  2>>"$LOG_FILE" || handle_error "Failed to generate CSR."

openssl x509 -req -days "$VALIDITY_DAYS" -in "$CSR" -signkey "$PRIVATE_KEY" -out "$CERTIFICATE" \
  2>>"$LOG_FILE" || handle_error "Failed to generate certificate."

chmod 600 "$PRIVATE_KEY" || handle_error "Failed key permission."
chmod 644 "$CERTIFICATE" || handle_error "Failed cert permission."

log "SSL generation completed successfully."
log "Key: $PRIVATE_KEY"
log "Cert: $CERTIFICATE"