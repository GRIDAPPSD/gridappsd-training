#!/bin/bash

# Install Miniconda
#curl --url https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh --output Miniconda-latest-Linux-x86_64.sh
#bash Miniconda-latest-Linux-x86_64.sh

# Collect prerequisite package
sudo apt-get update
sudo apt-get install -y pip
sudo apt-get install -y python3.8-venv
sudo apt-get install -y jupyter-core

# Create virtual environment
python3.8 -m venv gridappsd-env 
source gridappsd-env/bin/activate
python -m pip install pip --upgrade

# Install GridAPPSD-Python
pip install gridappsd-python

# Install JupyterLab
pip install jupyterlab

# Launch Notebooks
jupyter notebook --ServerApp.port 8890 --ServerApp.ip='0.0.0.0'
