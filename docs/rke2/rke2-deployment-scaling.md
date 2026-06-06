## This document demonstrates deployment creation and replica scaling using the Kubernetes imperative approach for cluster validation purposes.

### Create Deployment

`kubectl create deployment nginx --image=nginx`

<img width="474" height="49" alt="image" src="https://github.com/user-attachments/assets/d1c06544-6cf3-44a9-9d15-0e1aa7d8b01f" />

### Verify

`kubectl get deployment`

<img width="336" height="52" alt="image" src="https://github.com/user-attachments/assets/27085acb-16ea-4fcb-b082-b8ff53100ca2" />

<br>

<br>

### Check Running Pods in detailed view:

`kubectl get pods -o wide` 

<img width="849" height="52" alt="image" src="https://github.com/user-attachments/assets/a0075f7a-e1a3-408b-9b2d-ca72785febd1" />

<br>

<br>

### Scale Up Deployment

`kubectl scale deployment nginx --replicas=3`

<img width="439" height="58" alt="image" src="https://github.com/user-attachments/assets/0e5dc6d6-9d9f-482b-8568-3d098fc4075c" />

### Verify

`kubectl get deployments`

<img width="336" height="70" alt="image" src="https://github.com/user-attachments/assets/f1b0c03a-a9a8-45f2-a02d-849726a3fe42" />

<br>

<br>

### Verify Pod Distribution

`kubectl get pods -o wide`

<img width="862" height="84" alt="image" src="https://github.com/user-attachments/assets/eb959cc0-18c6-491d-8b1f-a4a3db5ead2a" />

### Purpose:

Verify Kubernetes Scheduler
Verify workload distribution across worker nodes



