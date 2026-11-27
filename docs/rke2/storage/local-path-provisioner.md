
## 1. Install Local Path Provisioner ##

`kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml`

<img width="969" height="186" alt="image" src="https://github.com/user-attachments/assets/7fa3a384-da6f-4b72-bbba-61451622fe9c" />

## 2. Verify the installation ##

`kubectl get pods -n local-path-storage`

<img width="529" height="67" alt="image" src="https://github.com/user-attachments/assets/6cf1d6ae-5e71-4c32-901a-8d0987047af8" />

### Check the StorageClass: ###

`kubectl get storageclass`

<img width="732" height="67" alt="image" src="https://github.com/user-attachments/assets/b1b0a23d-23db-4f80-a346-bd218c46d954" />

## 3. Set it as the default StorageClass ##

`kubectl patch storageclass local-path \
  -p '{"metadata":{"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'`

<img width="640" height="69" alt="image" src="https://github.com/user-attachments/assets/263e9616-1c0d-41be-8c49-9a286691f76d" />

### Verify ###

`kubectl get storageclass`

<img width="799" height="67" alt="image" src="https://github.com/user-attachments/assets/9c87ae67-ba19-428a-9de3-d80e5bf32fff" />










