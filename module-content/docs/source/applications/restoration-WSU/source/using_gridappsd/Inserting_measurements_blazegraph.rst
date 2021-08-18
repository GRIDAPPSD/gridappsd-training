
Clone the Powergrid-Models repository

.. code-block:: bash

  git clone https://github.com/GRIDAPPSD/Powergrid-Models.git

..


Install the required python module

.. code-block:: bash

  pip install SPARQLWrapper

..

Modify the Powergrid-Models/Meas/constants.py file.  Change the blazegraph_url to "http://localhost:8889/bigdata/sparql".

Create a temporary directory for the measurements files

.. code-block:: bash

  mkdir tmp
  cd tmp

..

List the feeder and feeder id

.. code-block:: bash

  python3 ../Powergrid-Models/Meas/ListFeeders.py 

..

Generate the measurements file using the feeder and feeder id from the previous step

.. code-block:: bash

  python3 ../Powergrid-Models/Meas/ListMeasureables.py ieee123pv _E407CBB6-8C8D-9BC9-589C-AB83FBF0826D

..

Load the measurements into Blazegraph

.. code-block:: bash

  for f in `ls -1 *txt`; do
    python3 ../Powergrid-Models/Meas/InsertMeasurements.py $f
  done

..
