function [] = init()
% Function that initialize the problem
%
% Inputs:
%   - world params (structure)
%
% Outputs: 
%   - name of the function to call the game
%   - initialized matrix of population
%   - initialized matrix of payoffs

global world

%% Testing 

%world.n = 25;
%world.N = 10;
%world.L = 6;
%world.p_loners = 0.3;
%world.p_cooperators = 0.5;

%% Initialize Population Matrix

pop_comp = rand(world.L,world.L); % generate random composition in LxL grid
world.composition = 1*(pop_comp > 1-world.p_cooperators) + ...
    2*((pop_comp < 1-world.p_cooperators) & (pop_comp > 1-world.density))+ ...
    0*(pop_comp < 1-world.density);

% sets only the populated slots (1es in "slots") and only if the random
% value is in the range of the percentile for each strategy given in main

world.n_cooperators = sum(world.composition(:)==1); 
world.n_loners = sum(world.composition(:)==0.5);
world.n_defectors = sum(world.composition(:)==0);

% need to actually count number of players with certain strategy, as there
% is some variance in the distribution

%   0    for empty slot
%   0.5  for loners
%   -1    for defectors
%   1    for cooperators
%   
%plot_pop(world);

%% Initialze Payoff Matrix

world.payoff = zeros(world.L);  % payoff now in an identical grid as the composition
% there are no payoffs before the first game has been played


%% status
% disp('initialized composition: ')
% disp(world.composition);
% disp('initialized payoff: ')
% disp(game.payoff)


end % end of function