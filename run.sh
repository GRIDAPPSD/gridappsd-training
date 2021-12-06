#!/bin/bash

# Start virtual environment
source /home/monish/Projects/GridAPPSD/gridappsd-env/bin/activate

# Start Notebooks
jupyter notebook --port 8890 --ip='0.0.0.0'

