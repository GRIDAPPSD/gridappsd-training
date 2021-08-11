#!/bin/bash

# Install Miniconda
curl --url https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh --output Miniconda-latest-Linux-x86_64.sh
bash Miniconda-latest-Linux-x86_64.sh

# Create virtual environment
pip install virtualenv
python3 -m venv gridappsd-env
source gridappsd-env/bin/activate
python -m pip install pip --upgrade


# Install GridAPPSD-Python
pip install gridappsd-python

# Install JupyterLab
pip install jupyterlab

# Launch Notebooks
jupyter notebook --port 8890 --ip='0.0.0.0'
