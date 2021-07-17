.. GridAPPSD-Python documentation master file, created by
   sphinx-quickstart on Wed Aug  7 17:08:44 2019.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

GridAPPS-D Sensor Simulator Service
============================

.. toctree::
   :maxdepth: 3

The `GridAPPSD's Sensor Simulator` simulates real devices based upon the magnitude of "prestine" simulated values.  This
service has been specifically designed to work within the gridappsd platform container.  The `GridAPPSD` platform will
start the service when it is specified as a dependency of an application or when a service configuration is specified
within the `GridAPPSD Visualization <https://gridappsd.readthedocs.io/en/latest/using_gridappsd/index.html>`_.  The image
below shows a portion of the configuration options available through the service configuration panel.

.. image:: /_static/sensor-simulator-service-configuration.png

Python Application Usage
------------------------

The python application using this service should require `gridappsd-sensor-simulator` as a requirement.  In addition,
the following python code shows how to get the correct topic for the service.

.. code-block::python

   from gridappsd import topics

   read_topic = topic.service_output_topic("gridappsd-sensor-simulator", simulation_id)

Service Configuration
---------------------

The sensor-config in the above image shows an example of how to configure a portion of the system to have sensor output.
Each mrid (`_99db0dc7-ccda-4ed5-a772-a7db362e9818`) will be monitored by this service and either use the default values
or use the specified values during the service runtime.

.. code-block:: json

   {
      "_99db0dc7-ccda-4ed5-a772-a7db362e9818": {
         "nominal-value": 100,
         "perunit-confidence-band": 0.01,
         "aggregation-interval": 30,
         "perunit-drop-rate": 0.01
      },
      "_ee65ee31-a900-4f98-bf57-e752be924c4d":{},
      "_f2673c22-654b-452a-8297-45dae11b1e14": {}
   }

The other options for the service are:

 * default-perunit-confidence-band
 * default-aggregation-interval
 * default-perunit-drop-rate
 * passthrough-if-not-specified

These options will be used when not specified within the sensor-config block.

.. note::

   Currently the nominal-value is not looked up from the database.  At this time services aren't able to tell
   the platform when they are "ready".  This will be implemented in the near future and then all of the nominal-values
   will be queried from the database.

Request Example
---------------

The following is a full request example for use within the context of the
`main GridAPPSD api <https://gridappsd.readthedocs.io/en/master/using_gridappsd/index.html#id5>`_.  This example uses
the 123 node system with 3 sensors simulated.  Also for this example those are the only measurements that will be
published to the output sensor output topic.

.. code-block:: json

   {
       "power_system_config": {
           "GeographicalRegion_name": "_73C512BD-7249-4F50-50DA-D93849B89C43",
           "SubGeographicalRegion_name": "_1CD7D2EE-3C91-3248-5662-A43EFEFAC224",
           "Line_name": "_C1C3E687-6FFD-C753-582B-632A27E28507"
       },
       "application_config": {
           "applications": []
       },
       "simulation_config": {
           "start_time": "1570041113",
           "duration": "120",
           "simulator": "GridLAB-D",
           "timestep_frequency": "1000",
           "timestep_increment": "1000",
           "run_realtime": false,
           "simulation_name": "ieee123",
           "power_flow_solver_method": "NR",
           "model_creation_config": {
               "load_scaling_factor": "1",
               "schedule_name": "ieeezipload",
               "z_fraction": "0",
               "i_fraction": "1",
               "p_fraction": "0",
               "randomize_zipload_fractions": false,
               "use_houses": false
           }
       },
       "test_config": {
           "events": [],
           "appId": ""
       },
       "service_configs": [{
           "id": "gridappsd-sensor-simulator",
           "user_options": {
               "sensors-config": {
                   "_99db0dc7-ccda-4ed5-a772-a7db362e9818": {
                       "nominal-value": 100,
                       "perunit-confidence-band": 0.02,
                       "aggregation-interval": 5,
                       "perunit-drop-rate": 0.01
                   },
                   "_ee65ee31-a900-4f98-bf57-e752be924c4d": {},
                   "_f2673c22-654b-452a-8297-45dae11b1e14": {}
               },
               "random-seed": 0,
               "default-aggregation-interval": 30,
               "passthrough-if-not-specified": false,
               "default-perunit-confidence-band": 0.01,
               "default-perunit-drop-rate": 0.05
           }
       }]
   }


Further information about the `GridAPPSD <https://gridappsd.readthedocs.org/>`_ platform can be found at
`https://gridappsd.readthedocs.org <https://gridappsd.readthedocs.org>`_.



