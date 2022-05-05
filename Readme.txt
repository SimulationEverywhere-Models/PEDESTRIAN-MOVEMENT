IMPORTANT :
1-In order to run the batch scripts properly, you need to make sure to have simuOriginal.exe in the same folder as the batch scripts.

2-Before visualizing any of the cell-devs simulations in CD++ Modeler, you need to run the corresponding batch file for it first, in order to load the correct grid layout values into the simulation.


-The batch files are meant to simulate "pedest_walk.ma".
-"pedest_walk_complex.bat" uses "pedest_path_complex.val" by copying it to a generic "pedest_path.val" file, to generate a simulation of the pedestrian movement on a complex grid layout.
-"pedest_walk_simple.bat" uses "pedest_path_simple.val" by copying it to a generic "pedest_path.val" file, to generate a simulation of the pedestrian movement on a simple grid layout.
-The batch files create log files for each of the simulation they ran.