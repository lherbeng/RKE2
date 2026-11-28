
## Verify MSSQL Pod Status ##

`kubectl get pods -A | grep -i mssql`

<img width="847" height="52" alt="image" src="https://github.com/user-attachments/assets/923d8727-ff8f-493d-8eb5-a651e221f3c6" />

## Verify MSSQL Services ##

`kubectl get svc -A | grep -i mssql`

<img width="745" height="70" alt="image" src="https://github.com/user-attachments/assets/8eb8aa49-a153-495b-8d52-26808f1b39e6" />

### Purpose: Check the Kubernetes Services exposed by MSSQL. ###

Explanation:
- mssql – Internal Kubernetes service.
- mssql-nodeport – External access through NodePort.
- 1433 – MSSQL default port.
- 31433 – Configured NodePort.

## Verify PersistentVolumeClaim (PVC) ##

`kubectl get pvc -n database`

<img width="1009" height="75" alt="image" src="https://github.com/user-attachments/assets/8aba86fb-6b32-474a-b795-43a21d7ef0d4" />

### Purpose: Verify that MSSQL successfully requested and received persistent storage. ###

Explanation:
- Bound – PVC successfully connected to a PersistentVolume.
- 5Gi – Requested storage capacity.
- RWO – ReadWriteOnce access mode.
- local-path – StorageClass used by MSSQL.

## Verify PersistentVolume (PV) ##

`kubectl get pv`

<img width="1087" height="103" alt="image" src="https://github.com/user-attachments/assets/ef683ef8-dc4e-4ff5-979f-c8387e32ff79" />

### Purpose: List available PersistentVolumes in the Kubernetes cluster. ###

### To inspect the specific MSSQL PV: ###

`kubectl get pv pvc-46785703-5e51-4f29-8388-9fa7bf85d130 -o yaml`

<details>
<summary>Click to view important fields</summary>

```yaml
metadata:
  annotations:
    local.path.provisioner/selected-node: masternode

spec:
  hostPath:
    path: /opt/local-path-provisioner/...

  nodeAffinity:
    required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          values:
          - masternode

  persistentVolumeReclaimPolicy: Delete
  storageClassName: local-path
```

</details>

<img width="780" height="727" alt="image" src="https://github.com/user-attachments/assets/bb26eb3d-41ca-4635-9fc5-0ce58bc14284" />

Explanation:
- selected-node – Node where storage was provisioned.
- hostPath – Actual directory on the node.
- nodeAffinity – Restricts the volume to its associated node.
- Delete – Volume data may be deleted when the PVC is deleted.

## Verify MSSQL Volume Mount ##

` kubectl describe pod mssql-0 -n database`

<img width="595" height="55" alt="image" src="https://github.com/user-attachments/assets/b9ff1ed9-5185-4935-b61b-0f324b3000d9" />

Explanation:
- /var/opt/mssql – SQL Server data directory.
- mssql-data – Kubernetes volume name.
- rw – Read and Write access.

### This confirms that the MSSQL container mounts the PVC at its SQL Server data directory. ###

## Verify Node Disk Capacity ##

#### Run this command directly on the node hosting MSSQL: ####

`df -h`

### Purpose: Check the available disk space and filesystem utilization. ###

<img width="493" height="118" alt="image" src="https://github.com/user-attachments/assets/d95f5e8d-3f35-4aa5-914a-87076d0dd1c9" />

Explanation:
- Size – Total filesystem capacity.
- Used – Used disk space.
- Avail – Available disk space.
- Use% – Percentage of disk utilization.





