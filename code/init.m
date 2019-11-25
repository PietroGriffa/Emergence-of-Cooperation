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
global last_game

%% Testing 

%world.n = 25;
%world.N = 10;
%world.L = 6;
%world.p_loners = 0.3;
%world.p_cooperators = 0.5;

%% Initialize Population Matrix

% get total number of cooperators and defectors
world.n_coop = world.n*world.p_cooperators; 
world.n_def = world.n*(1-world.p_cooperators);

%create random succession of indexes
succession = rand(world.L*world.L,1);
[useless,order] = sort(succession);

% distribute cooperators and defectors randomly using random indexes
world.composition = zeros(world.L,world.L);
coop_idx = order(1:world.n_coop);
def_idx = order((world.n_coop+1):(world.n_coop+world.n_def));
world.composition(coop_idx)=1;
world.composition(def_idx)=2;

%   0    for empty slot
%   1    for cooperators
%   2    for defectors

%% Initialze Payoff Matrix

world.payoff = zeros(world.L);  % payoff now in an identical grid as the composition
% there are no payoffs before the first game has been played

%% Initialize last_game

last_game.composition = world.composition;
last_game.payoff = world.payoff;

end % end of function