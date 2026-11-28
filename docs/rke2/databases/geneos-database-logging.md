<img width="1141" height="475" alt="image" src="https://github.com/user-attachments/assets/3553c7c9-d8d3-455f-af12-bd2e8b46a265" />## Create GeneosLogging database ##

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

