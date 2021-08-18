The Timeseries Data API allows you to query the timeseries data such as weather, simulation output and input. 

Query Request Queue
^^^^^^^^^^^^^^^^^^^
Query request should be sent on following queue: goss.gridappsd.process.request.data.timeseries

Query Weather data
^^^^^^^^^^^^^^^^^^

.. include:: api_examples/weather.rst

Example Request:
::

	{"queryMeasurement":"weather", 
	"queryFilter":{"startTime":"1357048800000000",
				"endTime":"1357048860000000"},
	"responseFormat":"JSON"}

Example Response for result format JSON:
::

	{ "data": [ { "Diffuse": 2.5305959999999996, 
			"AvgWindSpeed": 0, 
			"TowerRH": 70.65, 
			"long": "105.18 W", 
			"MST": "08:00", 
			"TowerDryBulbTemp": 16.124, 
			"DATE": "1/1/2013", 
			"DirectCH1": 0.08549150370000001, 
			"GlobalCM22": 2.53962588, 
			"AvgWindDirection": 0, 
			"time": 1357048800, 
			"place": "Solar Radiation Research Laboratory", 
			"lat": "39.74 N" }, 
		{ "Diffuse": 2.6431350599999996, 
			"AvgWindSpeed": 0, 
			"TowerRH": 70.41, 
			"long": "105.18 W", 
			"MST": "08:01", 
			"TowerDryBulbTemp": 15.908, 
			"DATE": "1/1/2013", 
			"DirectCH1": 0.045951777299999996, 
			"GlobalCM22": 2.6501118499999996, 
			"AvgWindDirection": 0, 
			"time": 1357048860, 
			"place": "Solar Radiation Research Laboratory", 
			"lat": "39.74 N" } ], 
	  "responseComplete": true, 
	  "id": "1998314042" }

Allowed values for queryFilter are:
::

	startTime[epoch number]
	endTime[epoch number]
	AvgWindDirection[number]
	AvgWindSpeed[number]
	Diffuse[number]
	DirectCH1[number]
	GlobalCM22[number]
	MST[number]
	TowerDryBulbTemp[number]
	TowerRH[number]
	lat[string]
	long[string]
	place[string]

Query Simulation Data
^^^^^^^^^^^^^^^^^^^^^

Returns simulation input or output data based on query filters

Example Request:
::

	{"queryMeasurement": "simulation",
 	"queryFilter": {"simulation_id": "582881157"},
	"responseFormat": "JSON"}


Example Response for result format JSON:
::

	{
	"data": { "measurements": [{ "name": "simulation",
			"points": [{ "row": { "entry": [
				{ "key": "hasMeasurementDifference", "value": "FORWARD" },
				{ "key": "hasSimulationMessageType", "value": "INPUT" },
				{ "key": "difference_mrid", "value": "c65d4ba9-8689-4838-970c-2983b54ed2e6" },
				{ "key": "simulation_id", "value": "582881157" },
				{ "key": "time", "value": "1562614884" },
				{ "key": "attribute", "value": "ShuntCompensator.sections" },
				{ "key": "value", "value": "0.0" },
				{ "key": "object","value": "_5405BE1A-BC86-5452-CBF2-BD1BA8984093" }]}},
			{ "row": { "entry": [
				{ "key": "hasMeasurementDifference", "value": "FORWARD" },
				{ "key": "hasSimulationMessageType", "value": "INPUT" },
				{ "key": "difference_mrid", "value": "c65d4ba9-8689-4838-970c-2983b54ed2e6" },
				{ "key": "simulation_id", "value": "582881157" },
				{ "key": "time", "value": "1562614884" },
				{ "key": "attribute", "value": "ShuntCompensator.sections" },
				{ "key": "value", "value": "0.0" },
				{ "key": "object", "value": "_8D0EAC3F-AD56-C5A6-ED03-863DBB4A8C5F"}]}}
	"responseComplete": true,
	"id": "1927836780" }

	
Allowed values for queryFilter are:
::

	Both input and output message type:
	starttime [number] 
	endtime [number]
	measurement_mrid [string] or [array of string values]
	simulation_id [string]
	hasSimulationMessageType ["OUTPUT" | "INPUT"]
	
	Ouput message type:
	angle [number]
	magnitude [number]
	
	Input Message type:
	hasMeasurementDifference  ["FORWARD"  | "REVERSE"]
	attribute [string]
	difference_mrid [string]
	object [string]
	value [number]

Please find some sample requests with various query filters
::
	{"queryMeasurement": "simulation",
 	"queryFilter": {"simulation_id": "582881157", "hasSimulationMessageType": "INPUT"},
	"responseFormat": "JSON"}

	{"queryMeasurement": "simulation",
 	"queryFilter": {"simulation_id": "582881157", "angle": 23.706919634782313},
	"responseFormat": "JSON"}
	
	{"queryMeasurement":"simulation",
	"queryFilter":{"simulation_id":"1743450224",
	"measurement_mrid":["_01625641-d9ae-4c34-8302-69a9620ec69d","_ffd6abc7-159d-4f6d-868b-7bf7b087ab85"]},
	"responseFormat":"JSON"}
	
Query Sensor Service  Data
^^^^^^^^^^^^^^^^^^^^^^^^^^

Returns output of sensor sensor service.

Example Request:
::

	{"queryMeasurement": "gridappsd-sensor-simulator",
 	"queryFilter": {"simulation_id": "582881157"},
	"responseFormat": "JSON"}
	
Example Response for result format JSON:
::	
		{
			"data": {
			"measurements": [
				{
				"name": "gridappsd-sensor-simulator",
				"points": [
					{
						"row": {
						"entry": [
							{
								"key": "instance_id",
								"value": "gridappsd-sensor-simulator-1564186315783"
							},
							{
								"key": "hasSimulationMessageType",
								"value": "OUTPUT"
							},
							{
								"key": "measurement_mrid",
								"value": "_0009caa4-23ef-41b9-9db7-624f3f47460c"
							},
							{
								"key": "angle",
								"value": "-152.44531328865978"
							},
							{
								"key": "magnitude",
								"value": "2470.4939175057075"
							},
							{
								"key": "simulation_id",
								"value": "1512566584"
							},
							{
								"key": "time",
								"value": "1564186297"
							}
							]
							}
					},.........]}]
			},
			"responseComplete": true,
			"id": "597021681"
		}


Allowed values for queryFilter are:
::

	starttime [number] 
	endtime [number]
	measurement_mrid [string]
	simulation_id [string]
	instance_id
	angle [number]
	magnitude [number]
	value [number]
