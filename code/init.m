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
%

global world
global last_game

%% Initialize Population Matrix

% get total number of cooperators and defectors
world.n_coop = round(world.n*world.p_cooperators);
world.n_def = world.n-world.n_coop;

%create random succession of indexes
succession = rand(world.L*world.L,1);
[~,order] = sort(succession);

% distribute cooperators and defectors randomly using random indexes
world.composition = zeros(world.L,world.L);
coop_idx = order(1:world.n_coop);
def_idx = order((world.n_coop+1):(world.n_coop+world.n_def));
world.composition(coop_idx)=1;
world.composition(def_idx)=2;
% disp(world.composition);
%   0    for empty slot
%   1    for cooperators
%   2    for defectors
%% Initialize Leaders
if world.leadership
    all_cooperators_idx = find(world.composition == 1);    %idx of all cooperators in world.composition
    world.leaders = all_cooperators_idx(randperm(length(all_cooperators_idx),world.n_leaders));    %randomly sample the first leader
else
    world.leaders = [];
end % end if

%% Initialze Payoff Matrix
world.payoff = zeros(world.L);  % payoff now in an identical grid as the composition
% there are no payoffs before the first game has been played

%% Initialize last_game
last_game.composition = world.composition;
last_game.payoff = world.payoff;

end % end of function