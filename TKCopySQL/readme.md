# Copy all rows from one Azure SQL Database table to another, 

## Solution structure:

### **SQLDB1** - point to source (and target in this sample) Azure SQL Database
### **SQLTBLSRC** - source table structure, important elements:
```json
   "availability": {
      "frequency": "Day",
      "interval": 1
    },
    "external": true,
    "policy": {
      "externalData": {
        "dataDelay": "00:00:00",
        "retryInterval": "00:01:00",
        "retryTimeout": "00:10:00",
        "maximumRetry": 3
      }
    }
```
### **SQLTBLDEST** - destination table structure, important elements:
```json
    "availability": {
      "frequency": "Day",
      "interval": 1
    },
    "external": false
```
### **TKSQLSRCDST** - copy activity, important elements:
#### Source
```json
    "source": {
                "type": "SqlSource",
                "sqlReaderQuery": "select data from tkADFSrc"
              }
```
#### Destination
```json
              "sink": {
                "type": "SqlSink",
                "sqlWriterStoredProcedureName": "spOverwritetkADFDst",
                "sqlWriterTableType": "tkADFSrcType",
                "sqlWriterCleanupScript": "delete from tkADFDst",
                "storedProcedureParameters": {
                  "date": {
                    "value": "2016-01-01T00:00:00Z"
                  },
                  "stringData": {
                    "value": "str1"
                  }
                },
                "writeBatchSize": 0,
                "writeBatchTimeout": "00:00:00"

              },
```
#### Stored procedure in SQL Database:
```SQL
CREATE PROCEDURE [dbo].[spOverwritetkADFDst] 
				@tkADFDst [dbo].[tkADFSrcType] READONLY, 
				@stringData varchar(256), @date datetime2
AS
BEGIN
    --DELETE FROM [dbo].[tkADFDst] -> this can be done as a part of copy activity
    INSERT [dbo].[tkADFDst]([data])
    SELECT [data] FROM @tkADFDst
END
```
#### Scheduler (and data slice)
````json
            "scheduler": {
              "frequency": "Day",
              "interval": 1
            },
````

###Result:
![Result](http://i.imgur.com/RTsbM2B.png)


## Additional information:

[SqlSink](https://msdn.microsoft.com/en-us/library/microsoft.azure.management.datafactories.models.sqlsink.aspx)

[Scheduling & Execution with Data Factory](https://azure.microsoft.com/en-us/documentation/articles/data-factory-scheduling-and-execution/)
