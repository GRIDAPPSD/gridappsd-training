# gridappsd-training




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