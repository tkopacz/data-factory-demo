
SQLDB1 - source

SQLTBLSRC - source table structure, important:
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
    


Result:
![Result](http://i.imgur.com/RTsbM2B.png)


Addtitional informations:

[https://msdn.microsoft.com/en-us/library/microsoft.azure.management.datafactories.models.sqlsink.aspx](SqlSink)

