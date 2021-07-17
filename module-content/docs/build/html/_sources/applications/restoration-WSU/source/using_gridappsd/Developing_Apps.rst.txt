
Download the application
------------------------------------------
  
* Clone or download the repository. The updated code is in the develop branch.

.. code-block:: bash

    gridappsd@gridappsd-VirtualBox:~$ git clone https://github.com/shpoudel/WSU-Restoration -b develop
    gridappsd@gridappsd-VirtualBox:~$ cd WSU-Restoration

..

Creating the application container
------------------------------------------

* From the command line execute the following commands to build the wsu-restoration container. Note that there is a dot at end of command.

.. code-block:: bash

     gridappsd@gridappsd-VirtualBox:~/WSU-Restoration$ docker build --network=host -t wsu-restoration-app .
..



Mount the application
-----------------------------------

* Add following to the docker-compose.yml file if CPLEX is available 

.. code-block:: bash

    wsu_res_app:
    image: wsu-restoration-app
    volumes:
      - /opt/ibm/ILOG/CPLEX_Studio129/:/opt/ibm/ILOG/CPLEX_Studio129
    environment:
      GRIDAPPSD_URI: tcp://gridappsd:61613
    depends_on:
      - gridappsd 
      
..

* Add following to the docker-compose.yml file if CPLEX is not available. In addition, replace prob.solve(CPLEX(msg=1)) with prob.solve() in restoration_WSU.py

.. code-block:: bash

    wsu_res_app:
    image: wsu-restoration-app
    environment:
      GRIDAPPSD_URI: tcp://gridappsd:61613
    depends_on:
      - gridappsd 
      
..
