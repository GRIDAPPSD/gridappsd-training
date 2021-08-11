#!/bin/bash

# Start virtual environment
source gridappsd-env/bin/activate

# Start Notebooks
jupyter notebook --port 8890 --ip='0.0.0.0'

