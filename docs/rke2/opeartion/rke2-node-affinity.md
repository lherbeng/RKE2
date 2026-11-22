
## Add a label to a node ## 

### List the nodes in your cluster, along with their labels: ###

`kubectl get nodes --show-labels`

<img width="1552" height="145" alt="image" src="https://github.com/user-attachments/assets/941ab866-6886-4975-8571-1261c2f8aec4" />

### Choose one of your nodes, and add a label to it: ###

`kubectl label nodes workernode2 disktype=ssd`

<img width="651" height="36" alt="image" src="https://github.com/user-attachments/assets/5bcd3fe6-4c13-4e0a-afd8-82a29ac59f6e" />

### Verify that your chosen node has a disktype=ssd label: ###

`kubectl get nodes --show-labels | grep disktype`

<img width="1056" height="55" alt="image" src="https://github.com/user-attachments/assets/27f16c05-a893-49ce-b559-c4c44ca58eac" />

## Schedule a Pod using required node affinity ##

### This manifest describes a Pod that has a requiredDuringSchedulingIgnoredDuringExecution node affinity,disktype: ssd. This means that the pod will get scheduled only on a node that has a disktype=ssd label. ###

`vi pod-nginx-required-affinity.yaml`

<img width="481" height="313" alt="image" src="https://github.com/user-attachments/assets/19733564-a697-4ae5-bda9-253b65d21318" />

### Apply the manifest to create a Pod that is scheduled onto your chosen node: ###

`kubectl apply -f pod-nginx-required-affinity.yaml`

<img width="652" height="49" alt="image" src="https://github.com/user-attachments/assets/09f7b9a5-ce03-4f1b-9d0c-6573990ea2a4" />

### Verify that the pod is running on your chosen node: ###

`kubectl get pods --output=wide`

<img width="739" height="67" alt="image" src="https://github.com/user-attachments/assets/e9d27c4d-6d2f-431c-a277-238ded62ac64" />

## Schedule a Pod using preferred node affinity ## 

### This manifest describes a Pod that has a preferredDuringSchedulingIgnoredDuringExecution node affinity,disktype: ssd. This means that the pod will prefer a node that has a disktype=ssd label. ###

`vi pod-nginx-preferred-affinity.yaml`

<img width="408" height="328" alt="image" src="https://github.com/user-attachments/assets/284c7438-9bc5-40de-9f27-9f7b41a03685" />

### Apply the manifest to create a Pod that is scheduled onto your chosen node: ###

`kubectl apply -f pod-nginx-preferred-affinity.yaml`

<img width="651" height="49" alt="image" src="https://github.com/user-attachments/assets/a0863dbc-5437-46c8-ad3c-6720e44116f5" />

### Verify that the pod is running on your chosen node: ###

`kubectl get pods --output=wide`

<img width="720" height="70" alt="image" src="https://github.com/user-attachments/assets/5b581271-f159-49a0-b5bc-1f9fc2f34bee" />

## Expected behavior: ##

### To remove the disktype=ssd label from workernode1, use: ###

`kubectl label nodes workernode2 disktype-`

<img width="588" height="36" alt="image" src="https://github.com/user-attachments/assets/e89a5d76-a281-436f-8096-665fcfec8ea0" />

### Verify that the label was removed ###

`kubectl get node workernode2 -L disktype`

<img width="586" height="75" alt="image" src="https://github.com/user-attachments/assets/561a8fd2-5ab3-44ad-8299-4c1668492aa9" />

### Preferred: Kubernetes favors workernode2, but can schedule the Pod on another eligible node if no node with the disktype=ssd label is available. ###

`kubectl apply -f pod-nginx-preferred-affinity.yaml`

<img width="649" height="55" alt="image" src="https://github.com/user-attachments/assets/0d9079b0-f942-4d90-99e2-30eff5bf159e" />

`kubectl get po -o wide`

<img width="724" height="69" alt="image" src="https://github.com/user-attachments/assets/608b47ca-ceeb-4460-8565-f638e08e19ec" />

### Required: Kubernetes only schedules the Pod on workernode1. ###
















## https://kubernetes.io/docs/tasks/configure-pod-container/assign-pods-nodes-using-node-affinity/ ##








