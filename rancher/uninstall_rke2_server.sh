#!/bin/bash

# Stop the RKE2 server
echo "Stopping RKE2 service..."
systemctl stop rke2-server
systemctl disable rke2-server

# Remove RKE2 binaries and data
echo "Removing RKE2 files and data..."
rm -rf /etc/rancher/rke2
rm -rf /var/lib/rancher/rke2
rm -rf /usr/local/bin/kubectl

# Clean up the kubeconfig and .bashrc export
echo "Cleaning up KUBECONFIG..."
sed -i '/export KUBECONFIG/d' ~/.bashrc

# Reload .bashrc changes
echo "Reloading bashrc..."
source ~/.bashrc

# Check if there’s anything left of kubectl
if [ -f "/usr/local/bin/kubectl" ]; then
    echo "Removing kubectl symlink..."
    rm /usr/local/bin/kubectl
else
    echo "kubectl already removed 👍"
fi

# Remove any unused packages
echo "Running autoremove to clean up..."
apt autoremove -y

# If you want to get really aggressive, comment this out!
# apt remove --purge -y nfs-common open-iscsi

echo "Uninstallation complete!"

