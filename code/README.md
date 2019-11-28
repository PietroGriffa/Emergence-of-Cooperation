# Code Folder 

All the Matlab code is stored in this folder.

## Prerequisites
Download and install Matlab:
* [Matlab](https://www.mathworks.com/products/matlab.html)

## Dependencies
Please install the following Matlab dependencies:
* [Image Processing Toolbox](https://www.mathworks.com/products/image.html)

## Reproducibility

In order to run the code and reproduce the results, please follow the following instructions:

* `git clone` this repository
* Open the `code` folder in Matlab
* Navigate to the `main.m` file and run the code

More explanation on the files and parameters can be found in the following sections and also in the report (see folder `doc`).

## Files

The folder contains the following files:
* `main.m`: The main file where all relevant parameters are defined and all functions called. To run the code, only this file needs to be executed.
* `init.m`: a function that initializes the game with the parameters defined in the `main.m` file.
* `migration.m`: a function with the main implementation of the game.
* `neighborhood_watch.m`: a function to get the sum of payoffs in the neighborhood of a playor.
* `success_driven_migration.m`: a function that explores the free spots around a player and checks if one is more profitable by doing test interactions.
* `imitate.m`: a function that updates the strategy of a player if another payoff in the neighborhood is more profitable.
* `noise.m`: a function that introduces noise.
* `plot_pop.m`: a function that plots the output.

## Parameters

All parameters that can be defined are commented in the respective matlab file, especially the `main.m`. The output is quite sensitive to some of the parameters, so we encourage to keep the predifined values in order to reproduce the outputs. More information on specific values and the functionality of paramters can also be found in the report (see folder `doc`).
