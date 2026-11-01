#!/bin/bash
set -e
set -x  # Enable debugging

# Ensure script runs as root
if [[ $EUID -ne 0 ]]; then
    echo "Please run this script as root."
    exit 1
fi

# Variables
RKE2_VERSION="v1.35.5+rke2r1"
RKE2_CONFIG="/etc/rancher/rke2/rke2.yaml"
KUBECONFIG_FILE="/root/.kube/config"
KUBECTL_BIN="/var/lib/rancher/rke2/bin/kubectl"
TIMEOUT=600

# Stop Firewall
systemctl disable --now ufw || true

# Update system and install required packages
apt update
apt install -y nfs-common open-iscsi
apt upgrade -y
apt autoremove -y

# Install RKE2 server
curl -sfL https://get.rke2.io | \
    INSTALL_RKE2_VERSION="${RKE2_VERSION}" \
    INSTALL_RKE2_TYPE=server sh -

# Enable and start RKE2 Server service
systemctl enable rke2-server.service
systemctl start rke2-server.service

# Wait for Kubernetes API server
echo "Waiting for Kubernetes API to become available..."

START_TIME=$(date +%s)

until [[ -f "${RKE2_CONFIG}" ]] && \
      "${KUBECTL_BIN}" --kubeconfig="${RKE2_CONFIG}" get nodes &>/dev/null; do

    CURRENT_TIME=$(date +%s)
    ELAPSED=$((CURRENT_TIME - START_TIME))

    if [[ ${ELAPSED} -ge ${TIMEOUT} ]]; then
        echo "ERROR: Kubernetes API did not become available within ${TIMEOUT} seconds."
        echo "Checking RKE2 service status..."
        systemctl status rke2-server --no-pager || true

        echo "Recent RKE2 logs:"
        journalctl -u rke2-server -n 100 --no-pager || true

        exit 1
    fi

    echo "Still waiting for Kubernetes API..."
    sleep 5
done

echo "Kubernetes API is responding."

# Get RKE2 master IP address
MASTER_IP=$(hostname -I | awk '{print $1}')

if [[ -z "${MASTER_IP}" ]]; then
    echo "ERROR: Unable to determine master IP address."
    exit 1
fi

# Update RKE2 kubeconfig with master IP
sed -i "s/127.0.0.1/${MASTER_IP}/g" "${RKE2_CONFIG}"

# Configure kubectl for root user
mkdir -p /root/.kube

cp "${RKE2_CONFIG}" "${KUBECONFIG_FILE}"

# Secure kubeconfig permissions
chmod 600 "${RKE2_CONFIG}"
chmod 600 "${KUBECONFIG_FILE}"

# Configure kubectl binary bundled with RKE2
install -m 0755 "${KUBECTL_BIN}" /usr/local/bin/kubectl

# Set KUBECONFIG for current session
export KUBECONFIG="${KUBECONFIG_FILE}"

# Configure KUBECONFIG for future root sessions
grep -qxF 'export KUBECONFIG=/root/.kube/config' /root/.bashrc || \
    echo 'export KUBECONFIG=/root/.kube/config' >> /root/.bashrc

echo "Kubeconfig configured successfully."
echo "Master IP: ${MASTER_IP}"

# Verify kubectl configuration
echo "Checking kubectl configuration..."
kubectl config view --minify

# Check Kubernetes nodes
echo "Checking Kubernetes nodes..."
kubectl get nodes -o wide || {
    echo "ERROR: kubectl cannot communicate with Kubernetes API."
    exit 1
}

# Display master network information
echo "Master network information:"
ip -br addr

# Display RKE2 server token
echo "RKE2 server node token:"
cat /var/lib/rancher/rke2/server/node-token

echo "RKE2 server installation script completed."