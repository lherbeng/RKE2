
## Create the SQL Server password Secret ##

### Create a database namespace ###

`kubectl create namespace database`

<img width="478" height="55" alt="image" src="https://github.com/user-attachments/assets/1c3f53b0-e1e2-44bf-9a32-0850bc8a85bf" />

### Then create the Secret: ###

`kubectl create secret generic mssql-secret \
  --namespace database \
  --from-literal=MSSQL_SA_PASSWORD='admin'`

<img width="562" height="85" alt="image" src="https://github.com/user-attachments/assets/e0d5f9b2-d371-4489-bfeb-ee803fea6ee6" />

### Note: Replace the example password with your own strong password. SQL Server requires a strong SA password. ###

### Verify ###

`kubectl get secret -n database`

<img width="451" height="67" alt="image" src="https://github.com/user-attachments/assets/985e2d85-b52e-4d3d-9fe1-a605099eddd4" />

## Create mssql.yaml ##

`vi mssql.yaml`

`kubectl apply -f mssql.yaml`


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

<img width="426" height="82" alt="image" src="https://github.com/user-attachments/assets/0709ec48-19ef-40a2-a681-96935e0f53f1" />










