# https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/

### Display node names and taints ### 

`kubectl get nodes -o custom-columns=NAME:.metadata.name,TAINTS:.spec.taints`

<img width="664" height="99" alt="image" src="https://github.com/user-attachments/assets/a5d8d683-40f5-46b3-9ac0-77fca6a78fb8" />

#### This command displays the taints assigned to each node. ####

### Check the control-plane label ###

`kubectl get nodes --show-labels | grep node-role.kubernetes.io/control-plane=`

<img width="1150" height="67" alt="image" src="https://github.com/user-attachments/assets/0c3be20d-a6e8-4234-b391-5405cdafb342" />

#### This command confirms which node has the control-plane label. ####

<span style="color: red;">Expected Result:</span>

#### The masternode should have the NoSchedule taint, while the worker nodes should remain without this taint. ####










