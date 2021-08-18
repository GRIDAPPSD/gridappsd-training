# Volt-Var Optimization (WSU)

This repository contains the restoration application for IEEE 9500-node model (https://github.com/GRIDAPPSD/Powergrid-Models/tree/develop/blazegraph/test/dss/WSU). The application is hosted on GridAPPS-D platform. 

## Layout

Please clone the repository https://github.com/GRIDAPPSD/gridappsd-docker (refered to as gridappsd-docker repository) next to this repository (they should both have the same parent folder)

## Creating the restoration application container

1.  From the command line execute the following commands to build the wsu-restoration container

    ```console
    osboxes@osboxes> cd WSU-VVO-app
    osboxes@osboxes> docker build --network=host -t wsu-vvo-app .
    ```

1.  Add the following to the gridappsd-docker/docker-compose.yml file

    ```` yaml
    wsu_vvo:
      image: wsu-vvo-app
      depends_on: 
        gridappsd    
    ````

1.  Run the docker application 

    ```` console
    osboxes@osboxes> cd gridappsd-docker
    osboxes@osboxes> ./run.sh
    
    # you will now be inside the container, the following starts gridappsd
    
    gridappsd@f4ede7dacb7d:/gridappsd$ ./run-gridappsd.sh
    
    ````
1.  Run the application container

    ```` console
    osboxes@osboxes> cd WSU-VVO-app
    osboxes@osboxes> docker exec -it gridappsddocker_wsu_vvo_1 bash
    
    # you will now be inside the application container, the following runs the application from terminal
    
    root@1b762c641f24:/usr/src/gridappsd-vvo# cd wsu_vvo
    root@1b762c641f24:/usr/src/gridappsd-vvo/wsu_vvo# python main.py 1234 '{"power_system_config":  {"Line_name":"_AAE94E4A-2465-6F5E-37B1-3E72183A4E44"}}'

    
    ````

Next to start the application through the viz follow the directions here: https://gridappsd.readthedocs.io/en/latest/using_gridappsd/index.html#start-gridapps-d-platform



## Forming optimization problem

In the optimization problem, test feeders are modeled as graph; G (V, E), where V is set of nodes and E is set of edges. The graph and line parameters of the test feeder can be extracted from (https://github.com/shpoudel/D-Net). 


## Get real-time topology and load data of the test case

First, the real time topology of the test case is extracted from the operating feeder in platform (top_identify.py). Then, load data for each node is obtained (get_Load.py) and stored in json format to be used in linear power flow while writing constraints for optimization problem.


