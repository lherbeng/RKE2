To show all pods running in the kube-system namespace, execute the following command:

`kubectl get pods -n kube-system`

<img width="683" height="493" alt="image" src="https://github.com/user-attachments/assets/8a6d46f2-ddfd-40c9-960a-679b020bc4cf" />

## **cloud-controller-manager-masternode**

The cloud-controller-manager is a Kubernetes control plane component that integrates the cluster with a cloud provider (or infrastructure layer). It runs controllers that interact with external resources like nodes, load balancers, and storage provided by the cloud or environment.

What it does:
Manages node lifecycle
Detects when nodes are added or removed
Handles service load balancers
Creates and manages external load balancers (if supported)
Manages route information
Ensures network routing is correctly configured
Integrates cloud-specific resources
Works with infrastructure outside Kubernetes


## **etcd-masternode**

A distributed key-value store that contains the entire cluster state, including information about pods, nodes, deployments, services, configurations, and secrets. Kubernetes relies on etcd as its source of truth.

## **kube-apiserver-masternode**

The main entry point of Kubernetes. All kubectl requests pass through the API server, and it provides access to the Kubernetes API. It acts as the control plane's front end and coordinates communication between cluster components.

## **kube-controller-manager-masternode**

The automation engine of Kubernetes. It continuously monitors the cluster and ensures that the actual state matches the desired state. For example, if a pod fails or is deleted, the controller manager creates a replacement pod to maintain the required number of replicas. It helps keep the cluster stable and healthy.

## **kube-proxy-masternode** 

Handles network communication inside the Kubernetes cluster. It manages network rules and enables services to connect to pods. It helps route traffic properly between components.

## **kube-proxy-workernode1** 

Runs on worker node 1 and performs the same role as kube-proxy on other nodes. It maintains network rules so pods on this node can communicate with other pods and services in the cluster.

## **kube-proxy-workernode2** 

Runs on worker node 2 with the same function. It ensures consistent networking by managing IP tables / IPVS rules and forwarding traffic to the correct pods.

## **kube-scheduler-masternode**

The Kubernetes component responsible for assigning newly created pods to the most suitable node in the cluster. It continuously watches for pods that do not yet have a node assigned and decides where they should run based on available resources (CPU, memory), constraints, policies, and scheduling rules.
It does not run the pods
It only decides which node should run them
It helps balance workload across the cluster and ensures efficient resource usage

## **rke2-canal-958sh / rke2-canal-f4q2d / rke2-canal-48b7h**

The rke2-canal pods are part of the RKE2 networking stack. Canal is a network plugin (CNI – Container Network Interface) used to provide networking and network policy enforcement inside the Kubernetes cluster.

Per node explanation:
Runs on the control plane node to handle networking for system pods and cluster components.
Manages networking for workloads running on worker node 1.
Manages networking for workloads running on worker node 2.

It is actually a combination of:
Flannel → handles pod-to-pod networking (basic networking layer)
Calico → handles network policies (security rules and traffic control)

Canal = Kubernetes networking layer (CNI)
Ensures pods can talk to each other across nodes
Combines Flannel (routing) + Calico (security policies)

## **rke2-coredns-rke2-coredns-69c9c9877c-5l6lj / rke2-coredns-rke2-coredns-69c9c9877c-8b9fs**

CoreDNS is the DNS (Domain Name System) service inside Kubernetes. It is responsible for resolving service names into IP addresses within the cluster.

Per pod explanation:
Handles DNS requests for system services and ensures cluster-wide name resolution is available.
Handles DNS queries from workloads running on worker nodes for fast and reliable name resolution.

## **rke2-coredns-rke2-coredns-autoscaler-645c95cdd7-fjwb2**

The rke2-coredns-autoscaler is a Kubernetes component that automatically adjusts the number of CoreDNS replicas based on cluster demand.

What it does:
Monitors CoreDNS load / CPU usage
Automatically scales CoreDNS pods up or down
Ensures DNS performance stays stable during high traffic
Helps prevent DNS bottlenecks in large or busy clusters

Why it is important:
If many pods start making DNS queries, it can increase CoreDNS replicas
If load is low, it can reduce replicas to save resources
Keeps DNS system efficient and highly available

## **rke2-ingress-nginx-controller-nbfs9 / rke2-ingress-nginx-controller-nqdvs / rke2-ingress-nginx-controller-wtfc7**

The rke2-ingress-nginx-controller is the component responsible for managing external access to services inside the Kubernetes cluster using HTTP and HTTPS routing rules.
It is based on NGINX Ingress Controller, which acts as a smart traffic gateway.

## **rke2-metrics-server-bdc688fb7-8mcbk**

The metrics-server is a Kubernetes component used to collect resource usage data from nodes and pods, such as CPU and memory usage.

What it does:
Collects live metrics from kubelets on each node
Provides data for commands like:
kubectl top nodes
kubectl top pods
Used by Horizontal Pod Autoscaler (HPA) to scale workloads automatically
Helps administrators monitor cluster resource usage

It tells Kubernetes “how much CPU and memory is being used right now”
Without it, Kubernetes cannot do real-time scaling or resource monitoring

## **rke2-snapshot-controller-6d8cd4bbcc-6cfh2**

The snapshot-controller manages volume snapshots in Kubernetes. It works with storage systems to create and manage backups of persistent volumes.

What it does:
Creates snapshots (backups) of Persistent Volumes (PVs)
Works with CSI (Container Storage Interface) drivers
Allows restoring data from snapshots
Used for backup and disaster recovery
