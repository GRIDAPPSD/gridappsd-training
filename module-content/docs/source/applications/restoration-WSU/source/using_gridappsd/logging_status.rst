.. _logging_status:

All applications and services should publish their log messages using using paltform;s log API.

Publishing Logs:
^^^^^^^^^^^^^^^^

Log messages should be published on the following topic. Simulation id should be attached to the topic at the end.
	
.. code-block:: console

	goss.gridappsd.simulation.log.[simulation_id]
	
Message structure for publishing logs :

.. code-block:: console

	{
		"source": "",
		"processId": "",
		"timestamp": "long",
		"processStatus": "[STARTED|STOPPED|RUNNING|ERROR|PASSED|FAILED]",
		"logMessage": "",
		"logLevel": "[INFO|DEBUG|ERROR]",
		"storeToDb": [true|false]
	}

where,

source is the filename publishing log message. 

processId is the simulation id.

timestamp is in epoch format.

storeToDb is true if you want to store this message in log database for later. 

	
Subscribing to Logs:
^^^^^^^^^^^^^^^^^^^^
For the currently running simulation, subcribe to following topic with simulation id appended at the end to receive real time logs:
	
.. code-block:: console

	goss.gridappsd.simulation.log.[simulation_id]
	
	
Querying Logs:
^^^^^^^^^^^^^^

Query request should be sent at following topic:

.. code-block:: console

	goss.gridappsd.process.request.data.log
	
User can query log data by sending either custom SQL query string or using query filters. 
 
1. Custom query string:

Logs are stored in MySQL database in a table named log with following columns: 
source, processId,timestamp, processStatus, logMessage, logLevel. 
User can create custom SQL query string to get log data:

.. code-block:: console

	{"query":"select * from log"}
	
Custom query response:

.. code-block:: console

	{ "data": [ 
		{ "process_id": "", "process_status": "RUNNING", "log_level": "INFO", "log_message": "Starting gov.pnnl.goss.gridappsd.app.AppManagerImpl", "id": "1", "source": "gov.pnnl.goss.gridappsd.app.AppManagerImpl", "timestamp": "2018-11-14 21:51:11.0", "username": "system" }, 
		{ "process_id": "", "process_status": "RUNNING", "log_level": "INFO", "log_message": "Found 0 applications", "id": "2", "source": "gov.pnnl.goss.gridappsd.app.AppManagerImpl", "timestamp": "2018-11-14 21:51:14.0", "username": "system" },
	], "responseComplete": true, "id": "1792453601" }

2. Query filters:

An example for query filters are 

.. code-block:: console

	{
		"source": "ProcessEvent",
		"processId": "12345678",
		"processStatus": "DEBUG",
		"logLevel": "DEBUG"
	}
	
For more details on log message filter look at 'Publishing Logs' section.

Custom query response:

.. code-block:: console

	{ "data": [ 
		{ "process_id": "414798372", "process_status": "RUNNING", "log_level": "DEBUG", "log_message": "New rewuest received", "id": "8", "source": "ProcessEvent", "timestamp": "2018-11-14 21:51:29.0", "username": "system" }, 
		{ "process_id": "", "process_status": "RUNNING", "log_level": "DEBUG", "log_message": "Running application", "id": "2", "source": "ProcessEvent", "timestamp": "2018-11-14 21:51:30.0", "username": "system" },
	], "responseComplete": true, "id": "1792453601" }

	
	
	