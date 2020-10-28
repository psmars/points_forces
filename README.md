# points&forces

Docker image of the [points&forces sourceforge](https://sourceforge.net/projects/pointsforces/) project.

Software tools facilitating the task of surveying architecture (real-time control, parametric modelling, use of digital photographs, processing of point clouds...).
Until now, those tools were mainly used to document cultural heritage sites/buildings

## For Linux

I you use GUI applications:

- be sure that the host is listening to TCP (not the default anymore)

- I use the command:
  `docker run --rm -it -e DISPLAY=:0 -v /tmp/.X11-unix:/tmp/.X11-unix absps/points_forces`

## For Windows

Install _VcXsrv Windows X Server_

