# https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/

### Display node names and taints ### 

`kubectl get nodes -o custom-columns=NAME:.metadata.name,TAINTS:.spec.taints`

<img width="664" height="99" alt="image" src="https://github.com/user-attachments/assets/a5d8d683-40f5-46b3-9ac0-77fca6a78fb8" />

#### This command displays the taints assigned to each node. ####

### Check the control-plane label ###

`kubectl get nodes --show-labels | grep node-role.kubernetes.io/control-plane=`

<img width="1150" height="67" alt="image" src="https://github.com/user-attachments/assets/0c3be20d-a6e8-4234-b391-5405cdafb342" />

#### This command confirms which node has the control-plane label. ####

### Expected Result: ###

#### The masternode should have the NoSchedule taint, while the worker nodes should remain without this taint. ####

### Apply Control-Plane Taint ### 

`kubectl taint nodes masternode node-role.kubernetes.io/control-plane=:NoSchedule`

<img width="703" height="52" alt="image" src="https://github.com/user-attachments/assets/e5fc215d-67b9-479c-b1fd-fdfc0fb5474b" />

### Verify the Taint ### 

`kubectl get nodes -o custom-columns=NAME:.metadata.name,TAINTS:.spec.taints`

<img width="667" height="100" alt="image" src="https://github.com/user-attachments/assets/ff472692-3534-4443-8d04-c2941bdc1a28" />

### Create a Deployment ###

`vi nginx-deployment.yaml`

<img width="268" height="328" alt="image" src="https://github.com/user-attachments/assets/0327fec3-a026-41f2-b603-e6f613ff0809" />

### Or ###

`kubectl create deploy nginx-deployment --image=nginx:latest --replicas=3 --dry-run=client -o yaml > nginx-deployment.yaml`

<img width="1141" height="441" alt="image" src="https://github.com/user-attachments/assets/f6e90d85-30c0-4960-8a86-c271ae5035f6" />

### Create the Deployment ###

`kubectl apply -f nginx-deployment.yaml`

<img width="586" height="64" alt="image" src="https://github.com/user-attachments/assets/87ca32d3-b374-44e8-b840-721aa42a8753" />

### Verify the pod placement ###

`kubectl get pods -o wide`

<img width="921" height="105" alt="image" src="https://github.com/user-attachments/assets/55a61862-d559-4d30-8895-249ee3e0d2d1" />

### Generate a Deployment YAML ###

`kubectl create deployment nginx-toleration --image=nginx:latest --replicas=3 --dry-run=client -o yaml > nginx.toleration.yaml`

<img width="387" height="409" alt="image" src="https://github.com/user-attachments/assets/caecde4e-ad01-40c8-8280-23885b7f2fa8" />





















