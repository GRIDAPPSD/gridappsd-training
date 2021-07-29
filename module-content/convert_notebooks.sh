#!/bin/bash

jupyter nbconvert installation/windows10/1.1W-Virtual-Machine-Docker-Setup.ipynb --output-dir='./docs/source/installation/windows10' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --EmbedImagesPreprocessor.embed_images=True  --to notebook
jupyter nbconvert installation/windows10/1.2W-Installing-GridAPPS-D.ipynb --output-dir='./docs/source/installation/windows10' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
jupyter nbconvert installation/windows10/1.3W-Installing-Python-Tutorials.ipynb --output-dir='./docs/source/installation/windows10' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
#jupyter nbconvert 1.0W--Module-1--Windows-10-Installation-Complete.ipynb --output-dir='./docs/source/' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook

jupyter nbconvert installation/1.4-Running-GridAPPS-D.ipynb --output-dir='./docs/source/installation' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
jupyter nbconvert installation/1.5-Using-GridAPPS-D-Viz.ipynb --output-dir='./docs/source/installation' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
jupyter nbconvert installation/1.6-Docker-Shortcuts.ipynb --output-dir='./docs/source/installation' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
jupyter nbconvert installation/1.7-Cloud-Server-Configuration.ipynb --output-dir='./docs/source/installation' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
jupyter nbconvert installation/1.8-Platform-Release-History.ipynb --output-dir='./docs/source/installation' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
cp -vr ./installation/images ./docs/source/installation

jupyter nbconvert overview/2.1-Intro-to-GridAPPS-D.ipynb --output-dir='./docs/source/overview' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
jupyter nbconvert overview/2.2-GridAPPS-D-Architecture.ipynb --output-dir='./docs/source/overview' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
jupyter nbconvert overview/2.3-GridAPPS-D-Python-Library.ipynb --output-dir='./docs/source/overview' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
jupyter nbconvert overview/2.4-GridAPPS-D-Application-Structure.ipynb --output-dir='./docs/source/overview' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
jupyter nbconvert overview/2.5-GridAPPS-D-Service-Structure.ipynb --output-dir='./docs/source/overview' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
jupyter nbconvert overview/2.6-Common-Information-Model.ipynb --output-dir='./docs/source/overview' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
cp -vr ./overview/images ./docs/source/overview

jupyter nbconvert api_usage/3.1-API-Communication-Channels.ipynb --output-dir='./docs/source/api_usage' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
jupyter nbconvert api_usage/3.2-API-Message-Structure --output-dir='./docs/source/api_usage' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
jupyter nbconvert api_usage/3.3-Using-the-PowerGrid-Models-API --output-dir='./docs/source/api_usage' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
jupyter nbconvert api_usage/3.4-Using-the-Configuration-File-API --output-dir='./docs/source/api_usage' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
jupyter nbconvert api_usage/3.5-Creating-Running-Simulation-API.ipynb --output-dir='./docs/source/api_usage' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
jupyter nbconvert api_usage/3.6-Controlling-Simulation-API.ipynb --output-dir='./docs/source/api_usage' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
jupyter nbconvert api_usage/3.7-Using-the-Timeseries-API.ipynb --output-dir='./docs/source/api_usage' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
cp -vr ./api_usage/images ./docs/source/api_usage

cp -vr ./images ./docs/source

#jupyter nbconvert  --output-dir='./docs/source/' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
#jupyter nbconvert  --output-dir='./docs/source/' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook

#cp -vr ./images/ ./docs/source/overview/images
