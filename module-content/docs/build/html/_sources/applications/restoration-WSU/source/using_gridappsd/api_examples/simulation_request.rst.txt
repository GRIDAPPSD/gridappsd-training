Start a Simulation
^^^^^^^^^^^^^^^^^^

Returns simulation id.   

Queue:

::

	goss.gridappsd.process.request.simulation
	
Example Request:

{

*power_system_config: the CIM model to be used in the simulation*
::
	
	"power_system_config": {
		"GeographicalRegion_name": "ieee8500nodecktassets_Region",
		"SubGeographicalRegion_name": "ieee8500nodecktassets_SubRegion",
		"Line_name": "ieee8500"
	},


*simulation_config: the paramaters used by the simulation*
::
	
	"simulation_config": {
		"start_time": "2009-07-21 00:00:00",
		"duration": "120",
		"simulator": "GridLAB-D",
		"timestep_frequency": "1000",
		"timestep_increment": "1000",
		"simulation_name": "ieee8500",
		"power_flow_solver_method": "NR",

*simulation_output: the objects and fields to be returned by the simulation*	
::
		
			"simulation_output": {
				"output_objects": [{
					"name": "rcon_FEEDER_REG",
					"properties": ["connect_type",
					"Control",
					"control_level",
					"PT_phase",
					"band_center",
					"band_width",
					"dwell_time",
					"raise_taps",
					"lower_taps",
					"regulation"]
				},
				.....]
			},

		
*model creation config: the paramaters used to generate the input file for the simulation*
::
	
		"model_creation_config": {
			"load_scaling_factor": "1",
			"schedule_name": "ieeezipload",
			"z_fraction": "0",
			"i_fraction": "1",
			"p_fraction": "0",
			"model_state":{
				"synchronousmachines":[
					{"name":"diesel590","p":100.000,"q":140.000},
					{"name":"diesel620","p":150.000,"q":500.000}
				],
				"switches":[
					{"name":"2002200004641085_sw","open":true},
					{"name":"2002200004868472_sw","open":true},
					{"name":"l9407_48332_sw","open":true},
					{"name":"tsw568613_sw","open":false}
				]
		    }
		}
	},
	
*application config: inputs to any other applications that should run as part of the simluation, in this case the voltvar application*
::
	
	"application_config": {
		"applications": [{
			"name": "vvo",
			"config_string": "{\"static_inputs\": {\"ieee8500\" : {\"control_method\": \"ACTIVE\", \"capacitor_delay\": 60, \"regulator_delay\": 60, \"desired_pf\": 0.99, \"d_max\": 0.9, \"d_min\": 0.1,\"substation_link\": \"xf_hvmv_sub\",\"regulator_list\": [\"reg_FEEDER_REG\", \"reg_VREG2\", \"reg_VREG3\", \"reg_VREG4\"],\"regulator_configuration_list\": [\"rcon_FEEDER_REG\", \"rcon_VREG2\", \"rcon_VREG3\", \"rcon_VREG4\"],\"capacitor_list\": [\"cap_capbank0a\",\"cap_capbank0b\", \"cap_capbank0c\", \"cap_capbank1a\", \"cap_capbank1b\", \"cap_capbank1c\", \"cap_capbank2a\", \"cap_capbank2b\", \"cap_capbank2c\", \"cap_capbank3\"], \"voltage_measurements\": [\"nd_l2955047,1\", \"nd_l3160107,1\", \"nd_l2673313,2\", \"nd_l2876814,2\", \"nd_m1047574,3\", \"nd_l3254238,4\"],       \"maximum_voltages\": 7500, \"minimum_voltages\": 6500,\"max_vdrop\": 5200,\"high_load_deadband\": 100,\"desired_voltages\": 7000,   \"low_load_deadband\": 100,\"pf_phase\": \"ABC\"}}}"
		}]
	}

Subscribe to Simulation Output
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Topic:
	
::

	/topic/goss.gridappsd.simulation.output.[simulation_id]
	
Where simulation_id is response from start simulation API.

Example Message:

::
	
	{
		"simulation_id" : "12ae2345",
	    "message" : {
	    	"timestamp" : "1357048800",
	        "measurements" : {
	            "123a456b-789c-012d-345e-678f901a234b":{
					"measurement_mrid" : "123a456b-789c-012d-345e-678f901a234b"
					"magnitude" : 3410.456,
					"angle" : -123.456
	        }
	    }
	}
	
Subscribe to Simulation Logs
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Topic:
	
::

	/topic/goss.gridappsd.simulation.log.[simulation_id]
	
Where simulation_id is response from start simulation API.

Example Message:

::
	
	{
		"source": "",
		"processId": "",
		"timestamp": "",
		"processStatus": "[STARTING|STARTED|STOPPED|RUNNING|ERROR|CLOSED|COMPLETE]",
		"logMessage": "",
		"logLevel": "[INFO|DEBUG|ERROR]",
		"storeToDb": [true|false]
	}
	
Send Input to Simulation
^^^^^^^^^^^^^^^^^^^^^^^^

Topic:
	
::

	/topic/goss.gridappsd.simulation.input.[simulation_id]

Example Message:

::
	
  {
    "command": "update",
    "input": {
        "simulation_id": "123456",
        "message": {
            "timestamp": 1357048800,
            "difference_mrid": "123a456b-789c-012d-345e-678f901a235c",
            "reverse_differences": [{

                    "object": "61A547FB-9F68-5635-BB4C-F7F537FD824E",
                    "attribute": "ShuntCompensator.sections",
                    "value": 1
                },
                {

                    "object": "E3CA4CD4-B0D4-9A83-3E2F-18AC5F1B55BA",
                    "attribute": "ShuntCompensator.sections",
                    "value": 0
                }
            ],
            "forward_differences": [{

                    "object": "61A547FB-9F68-5635-BB4C-F7F537FD824E",
                    "attribute": "ShuntCompensator.sections",
                    "value": 0
                },
                {

                    "object": "E3CA4CD4-B0D4-9A83-3E2F-18AC5F1B55BA",
                    "attribute": "ShuntCompensator.sections",
                    "value": 1
                }
            	]
        	}
    	}
  }

Pause Simulation
^^^^^^^^^^^^^^^^

Topic:

::

        /topic/goss.gridappsd.simulation.input.[simulation_id]

Example Message:

::

  {
      "command": "pause"
  }

Resume Simulation
^^^^^^^^^^^^^^^^^

Topic:

::

        /topic/goss.gridappsd.simulation.input.[simulation_id]

Example Message:

::

  {
      "command": "resume"
  }

Resume and Pause the Simulation after a Specified Number of Seconds
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Topic:

::

        /topic/goss.gridappsd.simulation.input.[simulation_id]

Example Message:

::

  {
      "command": "resumePauseAt",
      "input": {
          "pauseIn": 10
      }
  }
