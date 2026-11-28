
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





