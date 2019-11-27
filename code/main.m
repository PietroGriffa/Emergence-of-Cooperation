%% Main code
%
% Here is where all the functions are called
    
%% Tabula Rasa
close all
clear all
clc

%% World parameters

global world
global game
global last_game

% Values used in the literature of Helbing et al. (2011):
% density = 0.5
% p_cooperators = 0.5
% noise = 0.05
% L = 49
% Payoffs: R = 1, S = 0, T = 1.3, P = 0.1

% Grid
world.L = 49; % sidelength of the grid
world.rounds =  100; % amount of rounds to be played (t)

% Player distribution
world.density = 0.5;          % percentage of the grid should be populated [0,1]
% Attention: if density is 1, migration is not possible
world.N = 20;                 % number of people offered to play the game
world.p_cooperators = 0.5;    % percentage of cooperators

% Strategy Parameters
T = 0.8;  R = 0.3;  P = 0.1;  S = 0;
% Choose between the two matrices:
% world.payoff_mat = [R S; T P];                % original
world.payoff_mat = [R S 4*T; T P 0; 0 0 0];     % force leadership

% Migration Parameters
game.migration = true;
game.p_migration = 0.25;    % probability to imitate better strategies
game.M = 2;    % mobility range

% Imitation Parameters
game.imitation = true;
game.p_imitation = 0.25;    % probability to migrate to more favorable areas

%Noise Parameters (Random choice of the opposite strategy)
game.noise = true;
game.p_strat_noise = 0.01;

% Leadership Parameters (Leading by example: always cooperate and stationary)
world.leadership = true;
world.n_leaders = 5;

% DO NOT CHANGE
game.m = 1;    % neighborhood dimension
world.p_defectors = 1 - world.p_cooperators;            % percentage of defectors
world.n = round(world.density * (world.L)^2); %total number of players, rounds as we can't have non integer amount of players
%% Initialize 
% Call init function
init();
% disp(world.composition);
%% Run Game
% play test iterations within mobility Range to find the free square
% with the highest expected payoff

% DEBUG
if and(world.density == 1, game.migration == true)
    error("ERROR: migration is not possible without free fields (M = 1)")
end

if (world.N > world.n)
   error("ERROR: You can't choose more players to play than you have! (N>n)")
end

% Initial Data Aquisition
world.all_compositions = world.composition; %3 dim array with all compositions
world.all_payoffs = world.payoff; %3 dim array with all payoff matrices
world.all_migrated = 0; %how many players migrate each round
world.all_imitated = 0; % how many players imitated each round
world.all_cooperators = world.n_coop; % all n_coop saved over entire game
world.all_defectors = world.n_def; %all n_def saved over entire game

% Let players play game in their von Neuman Neighborhood
for round = 1:world.rounds
    disp(round);
    % Call migration() function with the main game logic
    migration();
    %NOTE: all changes made by this function are saved in the last_game
    %struct
    
    % Update world
%     disp('------ROUND------');
    world.composition = last_game.composition;
    world.payoff = last_game.payoff;
%     disp(world.composition);
%     disp(world.payoff);
    
    % Repeated Data Aquisition
    world.all_compositions(:,:,round+1) = world.composition;
    world.all_payoffs(:,:,round+1) = world.payoff;
    if (game.migration == true)
        world.all_migrated(round+1) = sum(last_game.migrated);
    end
    if (game.imitation == true)
        world.all_imitated(round+1) = sum(last_game.imitated);
    end
    world.all_cooperators(round+1) = sum(world.composition(:)==1);
    world.all_defectors(round+1) = sum(world.composition(:)==2);
    
    %DEBUG
%     empties_comp = find(world.composition==0);
%     empties_payo = find(world.payoff==0);
%     if (empties_comp ~= empties_payo)
%         erro  r("ERROR: There are empty slots that have nozero payoffs");
%     end
end

%% Plotting
% disp(world.composition);
total_players = world.all_cooperators+world.all_defectors;
t = [1:world.rounds+1];
pop_comp_plot = figure('Name','Population comparison',...
    'NumberTitle','off','Position',[700 50 500 500]);
ax2 = axes(pop_comp_plot);
plot(ax2,t,total_players,t,world.all_imitated,t,world.all_cooperators,t,world.all_defectors);
plot_pop();
% disp(world.composition);
% plot(t,world.all_cooperators,t,world.all_defectors);
%
% adapt strategy of neighbor if overall payoff of neighbor was higher than
% that of the focal player (choose closest if there are multiple options)
% if noise == true
% apply stragegy mutations (noise_1)
% apply random relocations (noise_2)
% (do both if we have noise_3)2
% end
%

