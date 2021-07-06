#!/bin/bash

jupyter nbconvert 1.1W--Lesson-1.1--Virtual-Machine-Docker-Setup.ipynb --output-dir='./docs/source/installation/windows10' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --EmbedImagesPreprocessor.embed_images=True  --to notebook

jupyter nbconvert 1.2W--Lesson-1.2--Installing-GridAPPS-D.ipynb --output-dir='./docs/source/installation/windows10' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
jupyter nbconvert 1.3W--Lesson-1.3--Running-GridAPPS-D.ipynb --output-dir='./docs/source/installation/windows10' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
jupyter nbconvert 1.4W--Lesson-1.4--Installing-Python-Tutorials.ipynb --output-dir='./docs/source/installation/windows10' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
#jupyter nbconvert 1.0W--Module-1--Windows-10-Installation-Complete.ipynb --output-dir='./docs/source/' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook

jupyter nbconvert 1.5--Lesson-1.5--Using-GridAPPS-D-Viz.ipynb --output-dir='./docs/source/installation' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
jupyter nbconvert 1.6--Lesson-1.6--Docker-Shortcuts.ipynb --output-dir='./docs/source/installation' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook

jupyter nbconvert 2.1--Lesson-2.1--Intro-to-GridAPPS-D.ipynb --output-dir='./docs/source/overview' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
cp -vr ./images/2.1 ./docs/source/overview/images/2.1

jupyter nbconvert 2.2--Lesson-2.2--GridAPPS-D-Architecture.ipynb --output-dir='./docs/source/overview' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
cp -vr ./images/2.2 ./docs/source/overview/images/2.2

jupyter nbconvert 2.3--Lesson-2.3--GridAPPS-D-Python-Library.ipynb --output-dir='./docs/source/overview' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
cp -vr ./images/2.3 ./docs/source/overview/images/2.3

jupyter nbconvert 2.4--Lesson-2.4--GridAPPS-D-Application-Structure.ipynb --output-dir='./docs/source/overview' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
cp -vr ./images/2.4 ./docs/source/overview/images/2.4

jupyter nbconvert 2.5--Lesson-2.5--GridAPPS-D-Service-Structure.ipynb --output-dir='./docs/source/overview' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
cp -vr ./images/2.5 ./docs/source/overview/images/2.5
jupyter nbconvert 2.6--Lesson-2.6--Common-Information-Model.ipynb --output-dir='./docs/source/overview' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
# cp -vr ./images/2.6 ./docs/source/overview/images/2.6

jupyter nbconvert 3.1--Lesson-3.1--API-Communication-Channels.ipynb --output-dir='./docs/source/api_usage' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
cp -vr ./images/3.1 ./docs/source/overview/images/3.1

jupyter nbconvert 3.2--Lesson-3.2--API-Message-Structure --output-dir='./docs/source/api_usage' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
cp -vr ./images/3.2 ./docs/source/overview/images3.2

jupyter nbconvert  3.3--Lesson-3.3--Using-the-PowerGrid-Models-API --output-dir='./docs/source/api_usage' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
cp -vr ./images/3.3 ./docs/source/overview/images/3.3

jupyter nbconvert 3.4--Lesson-3.4--Using-the-Configuration-File-API --output-dir='./docs/source/api_usage' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
cp -vr ./images/3.4 ./docs/source/overview/images/3.4

jupyter nbconvert  3.5--Lesson-3.5--Creating-Running-Simulation-API.ipynb --output-dir='./docs/source/api_usage' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
cp -vr ./images/3.5 ./docs/source/overview/images/3.5



#jupyter nbconvert  --output-dir='./docs/source/' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook
#jupyter nbconvert  --output-dir='./docs/source/' --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags 'remove_cell' --to notebook

#cp -vr ./images/ ./docs/source/overview/images







