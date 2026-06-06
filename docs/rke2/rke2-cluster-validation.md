## This document validates that the RKE2 cluster is fully operational after installation or changes. It confirms that the control plane, worker nodes, and system components are healthy and ready for workloads.

### Verifies that all nodes are registered in the cluster and shows their status (Ready/NotReady), roles, and versions.

`kubectl get nodes -o wide`

<img width="1138" height="52" alt="image" src="https://github.com/user-attachments/assets/583d8aff-d78e-4c8b-8e97-87649434f071" />

<br>

<br>

### Ensures all core Kubernetes and RKE2 components (CNI, scheduler, controller-manager, etc.) are running properly.

`kubectl get pods -n kube-system`

<img width="684" height="376" alt="image" src="https://github.com/user-attachments/assets/e31cc168-9e37-452f-9b68-255a294dd435" />

<br>

<br>

### Validates the health of core Kubernetes control plane components like:

`kubectl get componentstatuses`

<img width="367" height="103" alt="image" src="https://github.com/user-attachments/assets/599e904c-75bb-48cf-9934-6f07fb1a41b9" />

<br>

<br>

### Confirms that the RKE2 server process is running and stable at the OS level.

`systemctl status rke2-server`

<img width="1150" height="655" alt="image" src="https://github.com/user-attachments/assets/f14e3a4a-067e-44e5-9a71-30105c7a3047" />

<br>

<br>

### Tests Kubernetes API server readiness endpoint to ensure the cluster is responsive.

`kubectl get --raw='/readyz?verbose'`

<img width="741" height="676" alt="image" src="https://github.com/user-attachments/assets/fd7ed0fa-00d8-4fd9-90f7-86282487ae46" />

<br>

<br>

### Used for troubleshooting cluster startup or runtime issues by checking recent RKE2 service logs.

`journalctl -u rke2-server -n 100 --no-pager`

<img width="1146" height="681" alt="image" src="https://github.com/user-attachments/assets/46cf5a67-92d0-458b-8b05-fe5e3eebfb41" />

### Continuously monitors node status changes during validation or recovery.

`watch kubectl get nodes`

<img width="547" height="81" alt="image" src="https://github.com/user-attachments/assets/c409d7e8-e906-49ad-8960-f0bfc3618260" />







