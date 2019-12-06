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

More explanation on the files and parameters can be found in the following sections and also in the [report](../doc/report_cooperETHors.pdf) (see folder `doc`).

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

All parameters that can be defined are commented in the in the `main.m` and need to be changed there.

We encourage to use the parameters described in the following for reproducing the results of the report. First, the parameters to reproduce the findings of Helbing et. al (2011) are described withouth leadership. Second, the parameters to reproduce leadership are described.

### 1. Reproducing the results of Helbing et. al. (2011)

* ```world.L = 49``` (Grid-Length L)
* ```world.rounds = 50``` (Time steps t)
* ```world.densitiy = 0.5``` (Pecentage of empty slots)
* ```world.N = 60``` (Amount of people offered to play the game in each round. No specifications in the paper of Helbing et. al. (2011). We found values between 50 and 100 to be suited for reproduction, given the grid-lenth of L = 49.)
* ```world.p_cooperators = 0.5``` (Initial percentage of cooperators)
* Strategy parameters: ```T = 1.3;  R = 1;  P = 0.1;  S = 0```;
* Payoff matrix: ```world.payoff_mat = [R S; T P]``` (comment out the other);
* ```game.noise = true```;
* ```game.p_strat_noise = 0.01```;

In order to reproduce imitiation only:
* ```game.imitation = true```
* ```game.p_imitation = 1```
* ```game.migration = false```
* ```world.leadership = false```

In order to reproduce migration only:
* ```game.imitation = false```
* ```game.migration = true```
* ```game.p_migration = 1```
* ```game.M = 2```;  
* ```world.leadership = false```

In order to reproduce imitation combined with success-driven migration:
* ```game.imitation = true```
* ```game.p_imitation = 1```
* ```game.migration = true```
* ```game.p_migration = 1```
* ```game.M = 2```;  
* ```world.leadership = false```

### 2. Results of Leaderhsip:

* ```world.L = 49``` (Grid-Length L)
* ```world.rounds = 500``` (Time steps t)
* ```world.densitiy = 0.5``` (Pecentage of empty slots)
* ```world.N = 60``` (Amount of people offered to play the game in each round. No specifications in the paper of Helbing et. al. (2011). We found values between 50 and 100 to be suited for reproduction, given the grid-lenth of L = 49.)
* ```world.p_cooperators = 0.5``` (Initial percentage of cooperators)
* Strategy parameters: ```T = 2;  R = 1;  P = 0.1;  S = 0```;
* Payoff matrix: ```world.payoff_mat = [R   S   4*R;
                    T   P   0;  
                    R   S   R]``` (comment out the other);
* ```game.noise = true```;
* ```game.p_strat_noise = 0.01```;

In order to reproduce the first case described in the report (Figure 2, (c)/(d):

* ```game.migration = true```
* ```game.p_migration = 1```
* ```game.M = 2```
* ```game.imitation = true```
* ```game.p_imitation = 1```
* ```world.leadership = true```
* ```world.n_leaders = 10```

In order to reproduce the first case described in the report without leadership (Figure 2, (a)/(b), use the parameters above but:
* ```world.leadership = false```

In order to reproduce the second case described in the report (see report, Figure 2, (g)/(h):

* ```game.migration = true```
* ```game.p_migration = 0.25```
* ```game.M = 2```
* ```game.imitation = true```
* ```game.p_imitation = 0.25```
* ```world.leadership = true```
* ```world.n_leaders = 10```

In order to reproduce the second case described in the report without leadership (
    Figure 2, (e)/(f)), use the parameters above but:
* ```world.leadership = false```