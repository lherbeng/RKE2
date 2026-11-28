## Verify MSSQL Connectivity ## 

`nc -zv 192.168.68.5 31433`

<img width="396" height="54" alt="image" src="https://github.com/user-attachments/assets/92292833-e720-41b3-a484-3afb39640502" />

## Create GeneosLogging database ##

#### Open SSMS sa Windows. ####

#### Connect sa MSSQL server: ####

#### Click New Query. ####

<img width="346" height="334" alt="image" src="https://github.com/user-attachments/assets/534f9a26-ad1a-4b0b-8aa0-ceac1570df3a" />

#### Execute this: ####

<details>
<summary></summary>

```
CREATE DATABASE GeneosLogging;
GO
```

</details>

<img width="1141" height="475" alt="image" src="https://github.com/user-attachments/assets/3b9f1069-5e0a-4323-a0be-423726ddf8b7" />

## Verify ## 

#### Execute this: ####

<details>
<summary></summary>

```
SELECT name
FROM sys.databases
WHERE name = 'GeneosLogging';
```

</details>

<img width="1165" height="480" alt="image" src="https://github.com/user-attachments/assets/cf116577-60f4-4ad4-9373-cb3278074789" />

