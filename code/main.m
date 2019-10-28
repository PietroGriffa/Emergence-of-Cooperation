%% Main code
%
% Here is where all the functions should be called

%% World parametrs structure

% Common parameters
world.typeOfGame = 'red_queen';
world.population = (___)^2;    % must be a square
world.p_cooperators = ___;          % percentage of cooperators
world.p_defectors = ___;            % percentage of defectors
world.p_loners = 1 - (world.p_cooperators+world.p_defectors);   % percentage of loners
if world.typeOfGame == 'migration'
    % In the migration game we have no loners: spread the loners'
    % percentage between cooperators and defectors
    delta = world.p_loners;
    world.p_loners = 0;
    world.p_cooperators = world.p_cooperators + delta*0.5;
    world.p_defectors = world.p_defectors + delta*0.5;
end
world.n_cooperators = world.n_cooperators*world.population;
world.n_defectors = world.n_defectors*world.population;
world.n_loners = world.n_loners*world.population;

world.N = 500;   % number of people offered to play the game

% Paremeters for 'red_queen' game
world.imitation_strat = ___;    % imitation strategy

% Paremeters for 'migration' game
world.noise = ___;              % noise type
world.M = ___;                  % neighbourhood dimensions 

%% Initialize 
% Call init function
