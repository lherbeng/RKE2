
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





