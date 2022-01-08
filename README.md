# Docker Image for Data Analysis with Plotly
Simple template docker image to use Jupyterlab with plotly for data analysis

## Requirements

* `docker`
* `docker-compose`
* Only if using `start_docker_compose.ps1`, `Powershell`

## Usage

1. Data to be explored should be copied to `./data` directory
2. Run code `docker-compose up` in shell or run powershell script `start_docker_compose.ps1`
3. Open url from terminal output in browser

## Files

| File | Description |
|------|-------------|
|`notebooks/Analysis_Template.ipynb`| the start of a notebooks for data exploration |
|`docker-compose.yml` | docker-compose file to use to deploy jupyter lab |
|`Dockerfile`| the docker file that defines the image. Must be rebuilt if changed |
|`start_docker_compose.ps1`	| Using powershell, deploys docker-compose while finding an available port that is unused |
|`.env` | default env variables for `docker-compose.yml` |
|`data/tmp.txt` | file only to save that directory in git repo |
|`data/` | location to put data whish is shared with container |

## Notes
* using docker-compose command or scripts will not rebuild the image automatically 

## TODO

- [x] include scripts to run based on local env
- [ ] write start up as Make file so it works by default on more systems
- [x] add dark theme to docker file
- [x] add vim mode by default
