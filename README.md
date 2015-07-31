voovrat-utils : 

various scripts in octave(malab), python and bash for any purpose

Just look into the code to understand how it works (it is not too hard)

HOW TO INSTALL:

You need to setup PATH and PYTHONPATH to point this directory
if you are using bash - you may run 
  . ./utils_SetupPaths
this script will do the job for you (READ IT FIRST BEFORE RUNNING)
Also, check you ~/.bashrc file after running the script
There should 3 more lines like export $PATH=$PATH:$UTILS_PATH appear
But be careful:  some ~/.bashrc files do not execute the commands at the end of the file if the shell is non-interactive.
If it is your case - modify ~/.bashrc by hand just to be sure that the new 'export' lines are executed in each variant of shell start.

