Start the docker container services
-----------------------------------

* Note that this documentation is based on develop tag

.. code-block:: bash

  gridappsd@gridappsd-VirtualBox:~/gridappsd-docker$ ./run.sh -t develop

..

*The run.sh does the following*
 *  download the mysql dump file
 *  download the blazegraph data
 *  start the docker containers
 *  ingest the blazegraph data
 *  connect to the gridappsd container
 
The message in the container looks something like this:

.. code-block:: bash  

  Starting gridappsddocker_redis_1 ... 
  Starting gridappsddocker_proven_1 ... 
  Starting gridappsddocker_blazegraph_1 ... 
  Starting gridappsddocker_influxdb_1 ... 
  Starting gridappsddocker_mysql_1 ... done
  Starting gridappsddocker_gridappsd_1 ... done
  Starting gridappsddocker_wsu_res_app_1 ... 
  Starting gridappsddocker_wsu_res_app_1 ... done

  Getting blazegraph status

  Checking blazegraph data

  Blazegrpah data available (1954268)

  Getting viz status

  Containers are running

  Connecting to the gridappsd container
  docker exec -it gridappsddocker_gridappsd_1 /bin/bash

  gridappsd@78a3d22dd2b9:/gridappsd$
  
..

Restoration application container
-----------------------------------------------

.. code-block:: bash

  gridappsd@gridappsd-VirtualBox:~/WSU-Restoration$ docker exec -it gridappsddocker_wsu_res_app_1 bash
  
..

* This will take you inside the application container.

.. code-block:: bash

  root@1b762c641f24:/usr/src/gridappsd-restoration#
  
..


At this point, we should have two terminal open with gridappsd-docker container and restoration application terminal.

.. code-block:: bash

  root@1b762c641f24:/usr/src/gridappsd-restoration#
  gridappsd@78a3d22dd2b9:/gridappsd$

..


* Installing CPLEX in container

* Note that the installation command can be written inside the Dockerfile beforehand. However, we do the installation here manually before starting the platform. 

.. code-block:: bash

  root@1b762c641f24:/usr/src/gridappsd-restoration# cd /opt/ibm/ILOG/CPLEX_Studio129/cplex/python/3.6/x86-64_linux/ 
  root@1b762c641f24:/opt/ibm/ILOG/CPLEX_Studio129/cplex/python/3.6/x86-64_linux# python setup.py install
..

* ATTENTION: It is required that the application container has the python version compatible with the CPLEX. For example, CPLEX_STUDIO129 requires python 3.6. Thus, Python3.6 should be made available in the application container.


Executing the application container
-----------------------------------------------

* Now, get back to the path where application is mounted.

.. code-block:: bash

  root@1b762c641f24:/opt/ibm/ILOG/CPLEX_Studio129/cplex/python/3.6/x86-64_linux# cd /usr/src/gridappsd-restoration

..

* The following runs the application from terminal

.. code-block:: bash

  root@1b762c641f24:/usr/src/gridappsd-restoration# cd Restoration
  root@1b762c641f24:/usr/src/gridappsd-restoration/Restoration# python main.py [simulation_ID] '{"power_system_config":  {"Line_name":"_AAE94E4A-2465-6F5E-37B1-3E72183A4E44"}}'

..

* Running application from the terminal requires Simulation_ID. To get the correct Simulatio_ID, we need to start the platform through the browser. This will be explained in detail in the next section (Visualization).


Starting GridAPPS-D Platform
-----------------------------------------------

* Start the platform from the gridappsd-docker container

.. code-block:: bash

  gridappsd@78a3d22dd2b9:/gridappsd$ ./run-gridappsd.sh
..

* Following message can be seen at the end of running terminal. This confirms, the platform is running and we can start the application from the browser.

.. code-block:: bash

	Registering user roles: application2 --  application
	Registering user roles: application1 --  application
	Registering user roles: operator3 --  operator
	Registering user roles: operator2 --  operator
	Registering user roles: evaluator2 --  evaluator,operator
	Registering user roles: operator1 --  operator
	Registering user roles: evaluator1 --  evaluator,operator
	Registering user roles: testmanager2 --  testmanager
	Registering user roles: testmanager1 --  testmanager
	Registering user roles: service2 --  service
	Registering user roles: service.pid --  pnnl.goss.gridappsd.security.rolefile
	Registering user roles: service1 --  service
	CREATING LOG DATA MGR MYSQL
	{"id":"WSU_restoration","description":"Resilient Restoration Application","creator":"WSU","inputs":[],"outputs":[],"options":["(simulationId)","\u0027(request)\u0027"],"execution_path":"python /usr/src/gridappsd-restoration/Restoration/main.py","type":"REMOTE","launch_on_startup":false,"prereqs":["gridappsd-voltage-violation","gridappsd-alarms"],"multiple_instances":true}
	{"heartbeatTopic":"/queue/goss.gridappsd.remoteapp.heartbeat.WSU_restoration","startControlTopic":"/topic/goss.gridappsd.remoteapp.start.WSU_restoration","stopControlTopic":"/topic/goss.gridappsd.remoteapp.stop.WSU_restoration","errorTopic":"Error","applicationId":"WSU_restoration"}

..


	
