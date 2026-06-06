# This document validates that the RKE2 cluster is fully operational after installation or changes. It confirms that the control plane, worker nodes, and system components are healthy and ready for workloads.

Verifies that all nodes are registered in the cluster and shows their status (Ready/NotReady), roles, and versions.

`kubectl get nodes -o wide`

<img width="1138" height="52" alt="image" src="https://github.com/user-attachments/assets/583d8aff-d78e-4c8b-8e97-87649434f071" />

<br>

<br>

Ensures all core Kubernetes and RKE2 components (CNI, scheduler, controller-manager, etc.) are running properly.

`kubectl get pods -n kube-system`

<img width="684" height="376" alt="image" src="https://github.com/user-attachments/assets/e31cc168-9e37-452f-9b68-255a294dd435" />

<br>

<br>

Validates the health of core Kubernetes control plane components like:
