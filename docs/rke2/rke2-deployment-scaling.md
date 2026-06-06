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



