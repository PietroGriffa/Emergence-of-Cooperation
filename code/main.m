%% Main code
%
% Here is where all the functions should be called


%NOTATION:
    % [a,b] => values between a and b possible
    % {a,b,c,d} => any of the values in the brackets possible
    
%% Tabula Rasa
close all
clear all

%% World parametrs structure

% Grid
world.L = 5; % sidelength of the board => LxL players


% Game Type
world.migration = true;     % input for game whether there should be migration {true,false}
world.loners = false;        % or loners  {true,false}
world.noise = false;         % or noise  {true,false}
world.typeOfGame = 'migration';  % {'red_queen', false}
world.rounds = 5; %amount of rounds to be played

% Player distribution
world.density = 0.75; % what percentage of the grid should be populated [0,1], Attention: if density is 1, migration is not possible
world.n = round(world.density * (world.L)^2); %total number of players, rounds as we can't have non integer amount of players
world.N = 5;         % number of people offered to play the game
world.p_cooperators = 0.4;          % percentage of cooperators
world.p_loners =   0.2;    % percentage of loners

if world.loners == false  %if we have loners disabled, we ignore the value above and set it to 0
    world.loners = 0;
end
world.p_defectors = 1 - (world.p_cooperators+world.p_loners);            % percentage of defectors

world.n_cooperators = world.p_cooperators*world.n;
world.n_defectors = world.p_defectors*world.n;
world.n_loners = world.p_loners*world.n;

        
% Game Type specific parameters
world.M = 8;           % range of mobility for focal players => (M+1)x(M+1) grid with focal player in the center
world.noiseS_p = 0;          % how likely is a player to randomly switch strategys [0,1], Noise 1
world.noiseM_p = 0;          % how likely is a player to randomly relocate [0,1], Noise 2
                         % Noise 3 would be both noise1 and noise2 applied

% Strategy Parameters
world.r = 1.5;
if world.loners == true
    world.sigma = 0.75*(world.r-1);
else    % Prisoners Dilemma, T > R > P > S
    T = 5;
    R = 3;
    % loners should go here 
    P = 1;
    S = 0.5;
    world.payoff_mat = [R S; T P]
end

% Paremeters for 'red_queen' game
world.imitation_strat = 0;    % imitation strategy
% is the strategy change outlined in the Red Queen paper not basically
% noise 1?

% DEBUG
if and(world.density == 1, world.migration == true)
    disp("ERROR: migration is not possible without free fields (M = 1)")
    return
end

if (world.N > world.n)
   disp("ERROR: You can't choose more players to play than you have! (N>n)")
   return
end

    
    
    
%% Initialize 
% Call init function
[world, game] = init(world);
%disp(world.pop_composition); %for checks
%done


%% Run Game


[world, game] = play_round(world, game);

%for n = 1:world.rounds
%    [world,game] = play_round(world, game);
%    plot_pop(world,game);
%end
  
if world.migration == true
    % play test iterations within mobility Range to find the free square
    % with the highest expected payoff
    
    migration.migration = true;
    migration.p_migration = 0.5;    % probability to imitate better strategies
    
    migration.imitation = true;
    migration.p_imitation = 0.5;    % probability to migrate to more favorable areas
    
    migration.m = 1;    % neighborhood dimension
    
    % move focal player to said square
end
% let players play game in their Neuman Neighborhood

%
% adapt strategy of neighbor if overall payoff of neighbor was higher than
% that of the focal player (choose closest if there are multiple options)
% if noise == true
% apply stragegy mutations (noise_1)
% apply random relocations (noise_2)
% (do both if we have noise_3)2
% end
%

