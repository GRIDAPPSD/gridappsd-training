# gridappsd-training

## Python Training Notebooks
The Jupyter / iPython training notebooks are the source materials for the GridAPPS-D ReadTheDocs website.

The notebooks include all the code examples and sample app materials in a format that can connect to a local GridAPPS-D platform session and interact in real-time with simulations in real-time.

![switch_app_viz_interaction](https://user-images.githubusercontent.com/19935503/133678647-25d99dc2-bf25-470a-8eb2-e87ab3d2680f.gif)

### Download Python Training Notebooks

In the terminal window (use Miniconda terminal in Windows 10), clone the python notebooks by running `git clone https://github.com/GRIDAPPSD/gridappsd-training` to download the python training notebooks.

### Running Python Training Notebooks
Start the Jupyter notebooks running on port 8890 (to avoid port sharing conflict with the GridAPPS-D Blazegraph database container):

`jupyter notebook --port 8890`

If running on a remote server (e.g. AWS cloud or university / laboratory server farm), start the notebooks by running

`jupyter notebook --port 8890 --no-browser --ip='0.0.0.0'`


## Important note to Developers updating this repo:
Images embedded in the python notebooks must be formatted correctly to be converted by readthedocs:
* Must be placed in the appropriate directory
* Referenced by image file path and name
* Must have a unique alt text caption that
   * Does not contain any underscores (_)
   * Is not the same as the filename
* example: `![Example-image](../images/new_image.png)`

## Documentation Updated Export Process to readthedocs
* Update content in python notebooks in `module-content` directory
* Use `remove_cell` tag to flag any sections in python notebooks that should not be exported to readthedocs
* Images should be stored in the `~/images/section_number` folder
* Run `./convert_notebooks.sh` script to generate readthedocs files. These are saved in the `module-content/docs/source` directory
* Push updates to GitHub repo. This will trigger readthedocs to build the updated files.
