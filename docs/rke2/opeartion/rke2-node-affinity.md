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








