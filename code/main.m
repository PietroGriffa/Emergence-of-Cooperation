%% Main code
%
% Here is where all the functions should be called

% Define world parametrs structure
world.typeOfGame = 'red_queen';
world.population = (___)^2;    % must be a square
world.p_cooperators = ___;
world.p_defectors = ___;
world.p_loners = 1 - (world.p_cooperators+world.p_defectors);
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

