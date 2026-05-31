To show all pods running in the kube-system namespace, execute the following command:

`kubectl get pods -n kube-system`

<img width="683" height="493" alt="image" src="https://github.com/user-attachments/assets/8a6d46f2-ddfd-40c9-960a-679b020bc4cf" />


## **kube-apiserver-masternode**

The main entry point of Kubernetes. All kubectl requests pass through the API server, and it provides access to the Kubernetes API. It acts as the control plane's front end and coordinates communication between cluster components.

etcd-masternode 

A distributed key-value store that contains the entire cluster state, including information about pods, nodes, deployments, services, configurations, and secrets. Kubernetes relies on etcd as its source of truth.

kube-controller-manager-masternode 

The automation engine of Kubernetes. It continuously monitors the cluster and ensures that the actual state matches the desired state. For example, if a pod fails or is deleted, the controller manager creates a replacement pod to maintain the required number of replicas. It helps keep the cluster stable and healthy.
