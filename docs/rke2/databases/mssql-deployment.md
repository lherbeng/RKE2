
## Create the SQL Server password Secret ##

### Create a database namespace ###

`kubectl create namespace database`

<img width="478" height="55" alt="image" src="https://github.com/user-attachments/assets/1c3f53b0-e1e2-44bf-9a32-0850bc8a85bf" />

### Then create the Secret: ###

`kubectl create secret generic mssql-secret \
  --namespace database \
  --from-literal=MSSQL_SA_PASSWORD='Admin@Rhel'`

<img width="550" height="88" alt="image" src="https://github.com/user-attachments/assets/67f9a43d-d83c-4a5a-a4c3-27e516bcc4c9" />


### Note: Replace the example password with your own strong password. SQL Server requires a strong SA password. ###

### Verify ###

`kubectl get secret -n database`

<img width="451" height="67" alt="image" src="https://github.com/user-attachments/assets/985e2d85-b52e-4d3d-9fe1-a605099eddd4" />

## Create mssql.yaml ##

`vi mssql.yaml`

<details>
<summary>Click to view MSSQL YAML configuration</summary>

```yaml
apiVersion: v1
kind: Service
metadata:
  name: mssql
  namespace: database
spec:
  clusterIP: None
  selector:
    app: mssql
  ports:
    - name: sql
      port: 1433
      targetPort: 1433
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: mssql
  namespace: database
spec:
  serviceName: mssql
  replicas: 1
  selector:
    matchLabels:
      app: mssql
  template:
    metadata:
      labels:
        app: mssql
    spec:
      nodeSelector:
        kubernetes.io/hostname: masternode

      tolerations:
        - key: node-role.kubernetes.io/control-plane
          operator: Exists
          effect: NoSchedule

      securityContext:
        fsGroup: 10001

      containers:
        - name: mssql
          image: mcr.microsoft.com/mssql/server:2022-latest

          ports:
            - containerPort: 1433
              name: sql

          env:
            - name: ACCEPT_EULA
              value: "Y"

            - name: MSSQL_PID
              value: "Developer"

            - name: MSSQL_MEMORY_LIMIT_MB
              value: "1536"

            - name: MSSQL_SA_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: mssql-secret
                  key: MSSQL_SA_PASSWORD

          resources:
            requests:
              cpu: 500m
              memory: 1Gi
            limits:
              cpu: "2"
              memory: 2Gi

          volumeMounts:
            - name: mssql-data
              mountPath: /var/opt/mssql

          startupProbe:
            tcpSocket:
              port: 1433
            periodSeconds: 10
            failureThreshold: 30

          readinessProbe:
            tcpSocket:
              port: 1433
            periodSeconds: 10
            failureThreshold: 3

  volumeClaimTemplates:
    - metadata:
        name: mssql-data
      spec:
        accessModes:
          - ReadWriteOnce
        storageClassName: local-path
        resources:
          requests:
            storage: 5Gi
```

</details>

### Deploy MSSQL ###

`kubectl apply -f mssql.yaml`

<img width="426" height="82" alt="image" src="https://github.com/user-attachments/assets/0709ec48-19ef-40a2-a681-96935e0f53f1" />

## Create mssql-nodeport.yaml ##

`vi mssql-nodeport.yaml`

<details>
<summary>Click to view MSSQL Nodeport YAML configuration</summary>

```yaml
apiVersion: v1
kind: Service
metadata:
  name: mssql-nodeport
  namespace: database
spec:
  type: NodePort
  selector:
    app: mssql
  ports:
    - name: sql
      port: 1433
      targetPort: 1433
      nodePort: 31433
```

</details>

### Note: This allows you to access SQL Server from your Windows laptop, assuming your network and firewall allow access. ###

### Deploy MSSQL Nodeport ###

`kubectl apply -f mssql-nodeport.yaml`

<img width="493" height="66" alt="image" src="https://github.com/user-attachments/assets/efd2ebcf-37fe-4dc3-a2ce-bee28b66bf2a" />

## Validate the deployment ## 

### Check the Pod: ###

`kubectl get pods -n database -o wide`

<img width="742" height="67" alt="image" src="https://github.com/user-attachments/assets/5cac11c5-c04e-440b-88ef-a835a944ab24" />

### Check PVC: ###

`kubectl get pvc -n database`

<img width="994" height="67" alt="image" src="https://github.com/user-attachments/assets/584c02e0-4d5a-4885-898e-bbb2c68f4dcc" />

### Check PV: ###

`kubectl get pv`

<img width="1081" height="100" alt="image" src="https://github.com/user-attachments/assets/a14e8f95-d681-4c33-a051-50829a50ff57" />

### Check Services: ###

`kubectl get svc -n database` 

<img width="568" height="90" alt="image" src="https://github.com/user-attachments/assets/625eb02d-5263-478d-8386-d4a1ac6a628c" />


### Check logs: ###

`kubectl logs -n database mssql-0`

<img width="1090" height="588" alt="image" src="https://github.com/user-attachments/assets/1eeed440-cf25-4c4e-8141-b433abf36750" />
















