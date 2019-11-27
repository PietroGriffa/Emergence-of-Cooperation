# Code Folder 

All the Matlab code is stored in this folder.

## Prerequisites
* [Matlab](https://www.mathworks.com/products/matlab.html)

## Reproducibility

In order to run the code and reproduce the results, please follow the following instructions:

* `git clone` this repository
* Open this `code` folder in Matlab
* Navigate to the `main.m` file and run the code

More explanation on the files and parameters can be found in the following sections and also in the report (see folder `doc`).

## Files

The folder contains the following files:
* `main.m`: In this file all relevant parameters are defined and all functions called. To run the code, only this file needs to be executed.
* `init.m`: Function that initializes the game with the parameters defined in the `main.m` file.
* `migration.m`: function with the main implementation of the game.
* `neighborhood_watch.m`: function to get the sum of payoffs in the neighborhood of a playor.
* `success_driven_migration.m`: function that explores the free spots around a player and checks if one is more profitable by doing test interactions.
* `imitate.m`: function that updates the strategy of a player if another payoff in the neighborhood is more profitable.
* `noise.m`: function that introduces noise.

## Parameters

All parameters that can be defined are commented in the respective matlab file, especially the `main.m`. The output is quite sensitive to some of the parameters, so we encourage to keep the predifined values in order to reproduce the outputs. More information on specific values and the functionality of paramters can be found in the report (see folder `doc`).
