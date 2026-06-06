
### Verifies that worker nodes are registered in the cluster and shows their status, roles, and IP addresses.

`kubectl get nodes -o wide`

<img width="1164" height="87" alt="image" src="https://github.com/user-attachments/assets/f4caa19d-ef9d-466d-869c-69876045d414" />

<br>

<br>

### Confirms that nodes are correctly labeled as control-plane and worker

`kubectl get nodes --show-labels`

<img width="1288" height="157" alt="image" src="https://github.com/user-attachments/assets/536e1c33-7a44-416d-9a51-f7e21fb6324f" />

<br>

<br>

### Ensures system pods are running and scheduled properly across nodes (not stuck on control-plane only).

`kubectl get pods -n kube-system -o wide`

<img width="1116" height="490" alt="image" src="https://github.com/user-attachments/assets/a4dcda0e-9b19-4e7b-ad83-d30d9f20c7bd" />

<br>

<br>

### Provides detailed node health information such as CPU / memory pressure, kubelet status, event logs and readiness conditions

`kubectl describe node <worker-node-name>`

<img width="1249" height="636" alt="image" src="https://github.com/user-attachments/assets/6a0cac50-1232-4cef-ba25-3165cb689f80" />

<img width="1078" height="367" alt="image" src="https://github.com/user-attachments/assets/c0ef1c02-184c-407d-82be-0724e4bff1aa" />

<br>

<br>

### Confirms that the RKE2 agent service is active and running on the worker node.

`systemctl status rke2-agent`

<img width="1302" height="529" alt="image" src="https://github.com/user-attachments/assets/3d55fede-a3b1-4d4d-be74-92501a90ee71" />

<br>

<br>

### Used for troubleshooting worker node join failures, token issues, or network problems.

`journalctl -u rke2-agent -f`

<img width="1293" height="295" alt="image" src="https://github.com/user-attachments/assets/79431d8b-61ba-4ad3-a29e-0cfb4dab408d" />

