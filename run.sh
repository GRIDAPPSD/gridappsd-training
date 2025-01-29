#!/bin/bash

# Start virtual environment
source gridappsd-env/bin/activate

# Start Notebooks
jupyter notebook --ServerApp.port 8890 --ServerApp.ip='0.0.0.0'

