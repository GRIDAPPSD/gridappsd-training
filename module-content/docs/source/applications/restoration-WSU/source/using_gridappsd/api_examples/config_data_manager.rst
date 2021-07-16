
Request all GridLAB-D configuration files
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Generates all configuration files necessary to run a sumulation using the GridLAB-D simulator.  Returns the diretory where all of the configuration files are stored.

- Required: configurationType, parameters[model_id,directory,simulationname,simulation_start_time,simulation_duration,simulation_id,simulation_broker_host,simulation_broker_port]
- Optional: parameters[i_fraction, p_fraction, z_fraction, load_scaling_factor, schedule_name,solver_method]

Request: goss.gridappsd.process.request.config
::

  {
    "configurationType": "GridLAB-D All",
    "parameters": {
      "load_scaling_factor": "1.0",
      "i_fraction": "1.0",
      "model_id": "_C1C3E687-6FFD-C753-582B-632A27E28507",
      "p_fraction": "0.0",
      "simulation_id": "12345",
      "z_fraction": "0.0",
      "simulation_broker_host": "localhost",
      "simulation_name": "ieee8500",
      "simulation_duration": "60",
      "simulation_start_time": "1518958800",
      "solver_method": "NR",
      "schedule_name": "ieeezipload",
      "simulation_broker_port": "61616",
      "directory": "/tmp/gridlabdsimulation/"
    }
  }

Response:
<directory where files have been stored>
  
  
Request GridLAB-D Base File
^^^^^^^^^^^^^^^^^^^^^^^^^^^
Generates the main GLM file required by the GridLAB-D simulator

- Required: configurationType, parameters[model_id]
- Optional: parameters[simulation_id, i_fraction, p_fraction, z_fraction, load_scaling_factor, schedule_name]

Request:  goss.gridappsd.process.request.config
::

  {
    "configurationType": "GridLAB-D Base GLM",
    "parameters": {
      "i_fraction": "1.0",
      "z_fraction": "0.0",
      "model_id": "_C1C3E687-6FFD-C753-582B-632A27E28507",
      "load_scaling_factor": "1.0",
      "schedule_name": "ieeezipload",
      "p_fraction": "0.0"
    }
  }
  
Response:
::

  object regulator_configuration {
  name "rcon_reg1a";
  connect_type WYE_WYE;
	Control MANUAL; // LINE_DROP_COMP;
  .......

Request GridLAB-D Symbols File
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Generates the symbols file with XY coordinates used by the GridLAB-D simulator

- Required: configurationType, parameters[model_id]
- Optional: parameters[simulation_id]

Request:  goss.gridappsd.process.request.config
::

  {
    "configurationType": "GridLAB-D Symbols",
    "parameters": {
      "model_id": "_C1C3E687-6FFD-C753-582B-632A27E28507"
    }
  }
  
Response:
::
{"feeders":[
  {"name":"ieee123",
    "mRID":"_C1C3E687-6FFD-C753-582B-632A27E28507",
    "substation":"IEEE123",
    "substationID":"_FE44B314-385E-C2BF-3983-3A10C6060022",
    "subregion":"Medium",
    "subregionID":"_1CD7D2EE-3C91-3248-5662-A43EFEFAC224",
    "region":"IEEE",
    "regionID":"_73C512BD-7249-4F50-50DA-D93849B89C43",
    "swing_nodes":[
    {"name":"source","bus":"150","phases":"ABC","nominal_voltage":2401.8,"x1":100.0,"y1":1500.0}
    ],
    "synchronousmachines":[
    ],
    "capacitors":[
  .......


Request CIM Dictionary file
^^^^^^^^^^^^^^^^^^^^^^^^^^^
Generates a dictionary file which maps between the mrid identifiers used by the CIM model and the other names of model objects used by simulators.

- Required: configurationType, parameters[model_id]
- Optional: parameters[simulation_id]

Request: goss.gridappsd.process.request.config
::

  {
    "configurationType":"CIM Dictionary",
    "parameters":{"model_id":"_C1C3E687-6FFD-C753-582B-632A27E28507"}
   }

Response:
::

  {"feeders":[
	{"name":"ieee123",
	"mRID":"_C1C3E687-6FFD-C753-582B-632A27E28507",
	"substation":"IEEE123",
	"substationID":"_FE44B314-385E-C2BF-3983-3A10C6060022",
	"subregion":"Medium",
	"subregionID":"_1CD7D2EE-3C91-3248-5662-A43EFEFAC224",
	"region":"IEEE",
	"regionID":"_73C512BD-7249-4F50-50DA-D93849B89C43",
	"synchronousmachines":[
	],
	"capacitors":[
	{"name":"c83","mRID":"_232DD3A8-9A3C-4053-B972-8A5EB49FD980","CN1":"83","phases":"ABC","kvar_A":200.0,"kvar_B":200.0,"kvar_C":200.0,"nominalVoltage":4160.0,"nomU":4160.0,"phaseConnection":"Y","grounded":true,"enabled":false,"mode":null,"targetValue":0.0,"targetDeadband":0.0,"aVRDelay":0.0,"monitoredName":null,"monitoredClass":null,"monitoredBus":null,"monitoredPhase":null},
	{"name":"c88a","mRID":"_9A74DCDC-EA5A-476B-9B99-B4FB90DC37E3","CN1":"88","phases":"A","kvar_A":50.0,"kvar_B":0.0,"kvar_C":0.0,"nominalVoltage":4160.0,"nomU":2402.0,"phaseConnection":"Y","grounded":true,"enabled":false,"mode":null,"targetValue":0.0,"targetDeadband":0.0,"aVRDelay":0.0,"monitoredName":null,

  .......
  ]
  }]}

Request CIM Feeder Index file
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Generates a list of the feeders available powergrid model data store

- Required: configurationType, parameters[model_id]
- Optional: parameters[simulation_id]

Request: goss.gridappsd.process.request.config
::

  {
    "configurationType":"CIM Feeder Index",
    "parameters":{"model_id":"_C1C3E687-6FFD-C753-582B-632A27E28507"}
   }

Response:
::

  {"feeders":[
{"name":"test9500new","mRID":"_AAE94E4A-2465-6F5E-37B1-3E72183A4E44","substationName":"ThreeSubs","substationID":"_40485321-9B2C-1B8C-EC33-39D2F7948163","subregionName":"Large","subregionID":"_A1170111-942A-6ABD-D325-C64886DC4D7D","regionName":"IEEE","regionID":"_73C512BD-7249-4F50-50DA-D93849B89C43"},
{"name":"ieee123","mRID":"_C1C3E687-6FFD-C753-582B-632A27E28507","substationName":"IEEE123","substationID":"_FE44B314-385E-C2BF-3983-3A10C6060022","subregionName":"Medium","subregionID":"_1CD7D2EE-3C91-3248-5662-A43EFEFAC224","regionName":"IEEE","regionID":"_73C512BD-7249-4F50-50DA-D93849B89C43"},
  .......
  ]}

Request Simulation Output Configuration file
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Generates file containing objects and properties with measurements avilable in the selected model

- Required: configurationType, parameters[model_id]
- Optional: parameters[simulation_id]

Request: goss.gridappsd.process.request.config
::

  {
    "configurationType":"GridLAB-D Simulation Output",
    "parameters":{"model_id":"_C1C3E687-6FFD-C753-582B-632A27E28507"}
   }

Response:
::

  {
    "cap_capbank0a": [
      "switchA",
      "shunt_A",
      "voltage_A"
    ],

    "cap_capbank1b": [
      "switchB",
      "voltage_B",
      "shunt_B"
    ],
    "cap_capbank2c": [
      "voltage_C",
      "switchC",
      "shunt_C"
    ],
    "cap_capbank0b": [
      "voltage_B",
      "switchB",
      "shunt_B"
    ],.......


Request all OpenDSS configuration files
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Generates all configuration files necessary to run a sumulation using the OpenDSS simulator.  Returns the diretory where all of the configuration files are stored.

- Required: configurationType, parameters[model_id,directory,simulationname,simulation_start_time,simulation_duration,simulation_id,simulation_broker_host,simulation_broker_port]
- Optional: parameters[i_fraction, p_fraction, z_fraction, load_scaling_factor, schedule_name,solver_method]

Request: goss.gridappsd.process.request.config
::

  {
    "configurationType": "DSS All",
    "parameters": {
      "load_scaling_factor": "1.0",
      "i_fraction": "1.0",
      "model_id": "_C1C3E687-6FFD-C753-582B-632A27E28507",
      "p_fraction": "0.0",
      "simulation_id": "12345",
      "z_fraction": "0.0",
      "simulation_broker_host": "localhost",
      "simulation_name": "ieee8500",
      "simulation_duration": "60",
      "simulation_start_time": "1518958800",
      "solver_method": "NR",
      "schedule_name": "ieeezipload",
      "simulation_broker_port": "61616",
      "directory": "/tmp/dsssimulation/"
    }
  }

Response:
<directory where files have been stored>
  
  
Request OpenDSS Base File
^^^^^^^^^^^^^^^^^^^^^^^^^^^
Generates the main GLM file required by the OpenDSS simulator

- Required: configurationType, parameters[model_id]
- Optional: parameters[simulation_id, i_fraction, p_fraction, z_fraction, load_scaling_factor, schedule_name]

Request:  goss.gridappsd.process.request.config
::

  {
    "configurationType": "DSS Base",
    "parameters": {
      "i_fraction": "1.0",
      "z_fraction": "0.0",
      "model_id": "_C1C3E687-6FFD-C753-582B-632A27E28507",
      "load_scaling_factor": "1.0",
      "schedule_name": "ieeezipload",
      "p_fraction": "0.0"
    }
  }
  
Response:
::

  clear
  new Circuit.source phases=3 bus1=150 basekv=4.160 pu=1.00000 angle=0.00000 r0=0.00000 x0=0.00010 r1=0.00000 x1=0.00010
  new Linecode.11 nphases=1 units=mi rmatrix=[1.32920 ] xmatrix=[1.34750 ] cmatrix=[11.9873 ]
  new Linecode.1 nphases=3 units=mi rmatrix=[0.457600 | 0.156000 0.466600 | 0.153500 0.158000 0.461500 ] xmatrix=[1.07800 | 0.501700 1.04820 | 0.384900 0.423600 1.06510 ] cmatrix=[15.0567 | -4.85904 15.8641 | -1.85195 -3.08879 14.3156 ]


  .......

Request OpenDSS Coordinates File
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Generates the symbols file with XY coordinates used by the OpenDSS simulator

- Required: configurationType, parameters[model_id]
- Optional: parameters[simulation_id]

Request:  goss.gridappsd.process.request.config
::

  {
    "configurationType": "DSS Coordinate",
    "parameters": {
      "model_id": "_C1C3E687-6FFD-C753-582B-632A27E28507"
    }
  }
  
Response:
::

88,2950.0,1300.0
89,2775.0,1125.0
197,3525.0,2200.0
110,4275.0,3050.0
111,4275.0,3625.0
112,4275.0,2925.0
113,4800.0,2925.0
114,5125.0,2925.0
90,2775.0,900.0
61s,3175.0,1300.0
91,2550.0,1125.0
92,2550.0,825.0
93,2325.0,1125.0
94,2325.0,850.0
95,2025.0,1125.0
96,2025.0,925.0
97,3525.0,2100.0
98,3800.0,2100.0
10,1450.0,2150.0
99,4350.0,2100.0
11,950.0,2150.0
  .......




Request YBus Export Configuration file
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Generates file containing ybus configuration for the selected simulation.  Simulation must be running.

- Required: configurationType, parameters[simulation_id]

Request: goss.gridappsd.process.request.config
::

  {
    "configurationType":"YBus Export",
    "parameters":{"simulation_id":"12345"}
    }

Response:
::

  {
        "yParseFilePath": [
            "Row,Col,G,B",
            "1,1,517.6253721,-539.2591296",
            "2,1,-3.438703156,9.070554234",
            "3,1,-5.837170999,11.07061383",
            "4,1,-500,500",
            "84,1,-9.232329792,20.56428834",
            "85,1,1.801223903,-4.751238599",
            "86,1,3.057563114,-5.798887966"
	    ..........

