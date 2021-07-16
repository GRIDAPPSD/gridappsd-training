The Powergrid Model Data Manager API allows you to query the powergrid model data store. 

Query Request Queue
^^^^^^^^^^^^^^^^^^^
Query request should be sent on following queue: goss.gridappsd.process.request.data.powergridmodel

Query Model Info
^^^^^^^^^^^^^^^^

Returns list of names/ids for models, substations, subregions, and regions for all available feeders.  

Allowed parameter is:

- Result Format – XML/JSON/CSV, Will return results as a list in the format selected.

Example Request:
::

	{
		"requestType": "QUERY_MODEL_INFO",
		"resultFormat": "JSON"
	}

Example Response for result format JSON:
::

	{
		"models": [{
			"modelName": "ieee123",
			"modelId": "_C1C3E687-6FFD-C753-582B-632A27E28507",
			"stationName": "ieee123_Substation",
			"stationId": "_FE44B314-385E-C2BF-3983-3A10C6060022",
			"subRegionName": "large",
			"subRegionId": "_1CD7D2EE-3C91-3248-5662-A43EFEFAC224",
			"regionName": "ieee",
			"regionId": "_24809814-4EC6-29D2-B509-7F8BFB646437"
	}, .......


Query Model Names
^^^^^^^^^^^^^^^^^

Returns list of names for all available models.  

Allowed parameter is:

- Result Format – XML/JSON/CSV, Will return results as a list in the format selected.

Example Request:    goss.gridappsd.process.request.data.powergridmodel
::

	{
		"requestType": "QUERY_MODEL_NAMES",
		"resultFormat": "JSON"
	}

Example Response for result format JSON:
::

	{
		"modelNames": ["_49AD8E07-3BF9-A4E2-CB8F-C3722F837B62",
		"_4F76A5F9-271D-9EB8-5E31-AA362D86F2C3",
		"_5B816B93-7A5F-B64C-8460-47C17D6E4B0F",
		"_67AB291F-DCCD-31B7-B499-338206B9828F",
		"_9CE150A8-8CC5-A0F9-B67E-BBD8C79D3095",
		"_C1C3E687-6FFD-C753-582B-632A27E28507"]
	}
	
Python API function:
::

	query_model_names(self, model_id=None)


Query
^^^^^
Returns results from a generic SPARQL query against one or all models.

Allowed parameters are:

- modelId  (optional)  - when specified it searches against that model, if empty it will search against all models
- queryString  - SPARQL query, for more information see https://www.w3.org/TR/rdf-sparql-query/   See below for example.
- resultFormat – XML/JSON ,   The format you wish the result to be returned in.  Can be either JSON or XML.  Will return result bindings based on the select part of the query string.  See below for example.

Example Request:  goss.gridappsd.process.request.data.powergridmodel
::

	{
		"requestType": "QUERY",
		"resultFormat": "JSON",
		"queryString": "select ?feeder_name ?subregion_name ?region_name WHERE {?line r:type c:Feeder.?line c:IdentifiedObject.name  ?feeder_name.?line c:Feeder.NormalEnergizingSubstation ?substation.?substation r:type c:Substation.?substation c:Substation.Region ?subregion.?subregion  c:IdentifiedObject.name  ?subregion_name .?subregion c:SubGeographicalRegion.Region  ?region . ?region   c:IdentifiedObject.name  ?region_name}"
	}


Example Response:
::

	{
  	"head": {
   		 "vars": [ "line_name" , "subregion_name" , "region_name" ]
 	 } ,
  	"results": {
    		"bindings": [
     		 {
      	  		"line_name": { "type": "literal" , "value": "ieee8500" } ,
        		"subregion_name": { "type": "literal" , "value": "ieee8500_SubRegion" },
        		"region_name": { "type": "literal" , "value": "ieee8500_Region" }
    		  }
    		  ]
  	}
	}
	
Python API function:
::

	query_data(self, query, database_type=POWERGRID_MODEL, timeout=30) 


Query Object
^^^^^^^^^^^^
Returns details for a particular object based on the object Id.

Allowed parameters are:

- modelId (optional) - when specified it searches against that model, if empty it will search against all models
- objectID – mrid of the object you wish to return details for.
- resultFormat – XML/JSON ,  Will return result bindings based on the select part of the query string.

Example Request:  goss.gridappsd.process.request.data.powergridmodel
::

	{
		"requestType": "QUERY_OBJECT",
		"resultFormat": "JSON",
		"objectId": "_4F76A5F9-271D-9EB8-5E31-AA362D86F2C3"
	}
	
Example Response:
::

	{
	  "head": {
	    "vars": [ "property" , "value" ]
	  } ,
	  "results": {
	    "bindings": [
	      {
		"property": { "type": "uri" , "value": "http://iec.ch/TC57/2012/CIM-schema-cim17#Feeder.NormalEnergizingSubstation" } ,
		"value": { "type": "uri" , "value": "http://localhost:9999/blazegraph/namespace/kb/sparql#_F1E8E479-5FA0-4BFF-8173-B375D25B0AA2" }
	      } ,
	      {
		"property": { "type": "uri" , "value": "http://iec.ch/TC57/2012/CIM-schema-cim17#IdentifiedObject.mRID" } ,
		"value": { "type": "literal" , "value": "_4F76A5F9-271D-9EB8-5E31-AA362D86F2C3" }
	      } ,
	      {
		"property": { "type": "uri" , "value": "http://iec.ch/TC57/2012/CIM-schema-cim17#IdentifiedObject.name" } ,
		"value": { "type": "literal" , "value": "ieee8500" }
	      } ,
	      {
		"property": { "type": "uri" , "value": "http://iec.ch/TC57/2012/CIM-schema-cim17#PowerSystemResource.Location" } ,
		"value": { "type": "uri" , "value": "http://localhost:9999/blazegraph/namespace/kb/sparql#_AD650B25-8A04-EA09-95D4-4F78DD0A05E7" }
	      } ,
	      {
		"property": { "type": "uri" , "value": "http://www.w3.org/1999/02/22-rdf-syntax-ns#type" } ,
		"value": { "type": "uri" , "value": "http://iec.ch/TC57/2012/CIM-schema-cim17#Feeder" }
	      }
	    ]
	  }
	}
	
Python API function:
::

	query_object(self, object_id, model_id=None): 


Query Object Types
^^^^^^^^^^^^^^^^^^
Returns the available object types in the model

Allowed parameters are:

- modelId (optional) - when specified it searches against that model, if empty it will search against all models
- resultFormat – XML/JSON /CSV,  Will return results as a list in the format selected.

Example Request:   goss.gridappsd.process.request.data.powergridmodel
::

	{
		"requestType": "QUERY_OBJECT_TYPES",
		"modelId": "_4F76A5F9-271D-9EB8-5E31-AA362D86F2C3",
		"resultFormat": "JSON"
	}

	
Example Response:
::

	{
		"objectTypes": ["http://iec.ch/TC57/2012/CIM-schema-cim17#ConnectivityNode",
		"http://iec.ch/TC57/2012/CIM-schema-cim17#TransformerTank",
		"http://iec.ch/TC57/2012/CIM-schema-cim17#PowerTransformer",
		"http://iec.ch/TC57/2012/CIM-schema-cim17#LinearShuntCompensator",
		"http://iec.ch/TC57/2012/CIM-schema-cim17#EnergySource",
		"http://iec.ch/TC57/2012/CIM-schema-cim17#ACLineSegment",
		"http://iec.ch/TC57/2012/CIM-schema-cim17#LoadBreakSwitch",
		"http://iec.ch/TC57/2012/CIM-schema-cim17#EnergyConsumer"]
	}


Python API function:
::

	query_object_types(self, model_id=None) 


Query Model
^^^^^^^^^^^
Returns all or part of the specified model.  Can be filtered by object type

Allowed parameters are:

- modelId - when specified it searches against that model, if empty it will search against all models
- objectType (optional) – type of objects you wish to return details for.
- filter – SPARQL formatted filter string
- resultFormat – XML/JSON,  Will return result in the format selected.

Example Request:   goss.gridappsd.process.request.data.powergridmodel
::

	{
		"requestType": "QUERY_MODEL",
		"modelId": "_49AD8E07-3BF9-A4E2-CB8F-C3722F837B62",
		"resultFormat": "JSON",
		"filter": "?s cim:IdentifiedObject.name '650z'",
		"objectType": "http://iec.ch/TC57/CIM100#ConnectivityNode"
	}
	
Example Response:
::

	[{
		"id": "_0F9BF9EE-B900-71C2-B892-0287A875A158",
		"http://iec.ch/TC57/2012/CIM-schema-cim17#ConnectivityNode.ConnectivityNodeContainer": "_4F76A5F9-271D-9EB8-5E31-AA362D86F2C3",
		"http://iec.ch/TC57/2012/CIM-schema-cim17#ConnectivityNode.TopologicalNode": "_AE5EDB3A-9177-AEA6-78EF-3DDBA4557D94",
		"http://iec.ch/TC57/2012/CIM-schema-cim17#IdentifiedObject.mRID": "_0F9BF9EE-B900-71C2-B892-0287A875A158",
		"http://iec.ch/TC57/2012/CIM-schema-cim17#IdentifiedObject.name": "q14733",
		"http://www.w3.org/1999/02/22-rdf-syntax-ns#type": "http://iec.ch/TC57/2012/CIM-schema-cim17#ConnectivityNode"
	}]
	
	
Query Object Ids
^^^^^^^^^^^^^^^^
Returns details for a particular object based on the object Id.

Allowed parameters are:

- modelId - when specified it searches against that model, if empty it will search against all models
- objectType (optional) – type of objects you wish to return details for.
- resultFormat – XML/JSON/CSV ,  Will return result bindings based on the select part of the query string.

Example Request:   goss.gridappsd.process.request.data.powergridmodel
::

	{
		"modelId": "_4F76A5F9-271D-9EB8-5E31-AA362D86F2C3",
		"requestType": "QUERY_OBJECT_IDS",
		"resultFormat": "JSON",
		"objectType": "LoadBreakSwitch"
	}
	
Example Response:
::
	
	{
	  "objectIds": [
		"_0D2157F2-CD4D-9F68-9212-F663C472AF1C",
		"_18D43D9E-36D1-3A2C-AC8F-439232FC1EE2",
		"_323C2BDB-69AA-A10C-CEC5-628C77B83268",
		"_D7AA7B55-E700-F1E8-B3EB-CB2FB07F8A37",
		.......
	  ]
	}
	

Query Object Dictionary 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Returns details for either all objects of a particular type or a particular object based on the object Id.  Either the object type or id is required, but not both.

Allowed parameters are:

- modelId - model that you wish to return objects from.
- objectType (not required if objectId is set) – type of object you wish to return details for.
- objectId (not required if objectType is set) - mrid of the object you wish to return details for, if set this will override objectType.  
- resultFormat – XML/JSON ,  Will return result bindings based on the select part of the query string.

Example Request:   goss.gridappsd.process.request.data.powergridmodel
::

	{
		"modelId": "_4F76A5F9-271D-9EB8-5E31-AA362D86F2C3",
		"requestType": "QUERY_OBJECT_DICT",
		"resultFormat": "JSON",
		"objectType": "LinearShuntCompensator",
		"objectId": "_EF2FF8C1-A6A6-4771-ADDD-A371AD929D5B"
	}
	
Example Response:
::
	
	{
	 [
	   {
		"id": "_2199D08B-9352-2085-102F-6B207E0BEBA3",
		"ConductingEquipment.BaseVoltage": "_C0A00494-BB68-7476-57E3-9741545AE287",
		"Equipment.EquipmentContainer": "_4F76A5F9-271D-9EB8-5E31-AA362D86F2C3",
		"IdentifiedObject.mRID": "_2199D08B-9352-2085-102F-6B207E0BEBA3",
		"IdentifiedObject.name": "capbank0a",
		"PowerSystemResource.Location": "_19B9D45D-F556-01D4-8094-3AE64D5E63A0",
		"LinearShuntCompensator.b0PerSection": "100",
		"LinearShuntCompensator.bPerSection": "0.0077160494",
		"LinearShuntCompensator.g0PerSection": "0",
		"LinearShuntCompensator.gPerSection": "0",
		"ShuntCompensator.aVRDelay": "100",
		"ShuntCompensator.grounded": "true",
		"ShuntCompensator.maximumSections": "1",
		"ShuntCompensator.nomU": "7200",
		"ShuntCompensator.normalSections": "1",
		"ShuntCompensator.phaseConnection": "PhaseShuntConnectionKind.Y",
		"type": "LinearShuntCompensator"
	   },....	
	 ]
	}

Query Object Measurements
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Returns details for measurements within a model, can be for all objects of a particular type or for those connected to a particular object based on the objectId. If neither objectType or objectId is provided it will provide all measurements belonging to the model.

Allowed parameters are:

- modelId - model that you wish to return measurements from.
- objectType (optional) – type of object you wish to return measurements for.
- objectId (optional) - mrid of the object you wish to return measurements for.  If set this will override objectType. 
- resultFormat – XML/JSON ,  Will return result bindings based on the select part of the query string.

Example Request:   goss.gridappsd.process.request.data.powergridmodel
::

	{
		"modelId": "_4F76A5F9-271D-9EB8-5E31-AA362D86F2C3",
		"requestType": "QUERY_OBJECT_MEASUREMENTS",
		"resultFormat": "JSON",
		"objectType": "LinearShuntCompensator",
		"objectId": "_2199D08B-9352-2085-102F-6B207E0BEBA3"
	}
	
Example Response:
::

	[
      {
            "measid": "_59d526ff-32c0-4947-ab58-45f283636786",
            "type": "PNV",
            "class": "Analog",
            "name": "ACLineSegment_ln5532752-2_Voltage",
            "bus": "m1047534",
            "phases": "A",
            "eqtype": "ACLineSegment",
            "eqname": "ln5532752-2",
            "eqid": "_7A02B3B0-2746-EB24-45A5-C3FBA8ACB88E",
            "trmid": "_6B5B889C-E7E1-3444-CC63-7A589AC0DA8F"
        },....	
	 ]
	






Put Model
^^^^^^^^^
.. note:: Future Capability. Not yet available.

Inserts a new model into the model repository. This could validate model format during insertion  **Keep cim/model version in mind**

Allowed parameters are:

- modelId – id to store the new model under, or update existing model
- modelContent – expects either RDF/XML or JSON formatted powergrid model
- inputFormat – XML/JSON
