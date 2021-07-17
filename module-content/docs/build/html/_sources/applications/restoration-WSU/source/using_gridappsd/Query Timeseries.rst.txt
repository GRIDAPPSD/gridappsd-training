Query Time-series database
--------------------------

Connect to the running GridAPPS-D container

.. code-block:: bash

  user@foo>docker exec -it gridappsddocker_gridappsd_1 bash

..

Now we are inside the executing container. Start the platform.

.. code-block:: bash

  root@737c30c82df7:/gridappsd# ./run-docker.sh

..

Open your browser to http://localhost:8080/ and click the menu button.

.. figure:: home.png
    :align: left
    :alt: home-image
    :figclass: align-left
    
Select Browse Database from the menu.

.. figure:: VizMenu.jpg
	:align: left
	:alt: viz-menu
	:figclass: align-left
	
Select the time-series option.

.. figure:: VizDatabaseBrowser.jpg
	:align: left
	:alt: database-browser
	:figclass: align-left

Enter the time-series query in the textarea and the results will be displayed in the space below the textarea.

Stop GridAPPS-D platform
------------------------

For an orderly shutdown of the platform:
  
.. code-block:: bash

  Use Ctrl+C to stop gridappsd from running





