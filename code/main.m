%% Main code
%
% Here is where all the functions should be called
    
%% Tabula Rasa
close all
clear all
clc

%% World parametrs structure

global world

% Grid
world.L = 50; % sidelength of the board

world.rounds = 200; % amount of rounds to be played

% Player distribution
world.density = 0.5; % what percentage of the grid should be populated [0,1], Attention: if density is 1, migration is not possible
world.n = round(world.density * (world.L)^2); %total number of players, rounds as we can't have non integer amount of players
world.N = 100;         % number of people offered to play the game
world.p_cooperators = 0.5;          % percentage of cooperators

world.p_defectors = 1 - world.p_cooperators;            % percentage of defectors

% Strategy Parameters
T = 1.3;  R = 1;  P = 0.1;  S = 0;
world.payoff_mat = [R S; T P];

%% Initialize 
% Call init function
init();
% disp(world.composition);
%% Run Game

% play test iterations within mobility Range to find the free square
% with the highest expected payoff

global game
global last_game

game.migration = true;
game.p_migration = 1;    % probability to imitate better strategies

game.imitation = true;
game.p_imitation = 0.25;    % probability to migrate to more favorable areas

game.noise = false;
game.p_mig_noise = 0.05;
game.p_strat_noise = 0.05;

game.leaders = true;
game.n_leaders = 5;
game.leader_influence = 2;



game.m = 1;    % neighborhood dimension
game.M = 2;    % mobility range

% DEBUG
if and(world.density == 1, game.migration == true)
    error("ERROR: migration is not possible without free fields (M = 1)")
end

if (world.N > world.n)
   error("ERROR: You can't choose more players to play than you have! (N>n)")
end

% Data Aquisition
world.all_compositions = world.composition; %3 dim array with all compositions
world.all_payoffs = world.payoff; %3 dim array with all payoff matrices
world.all_migrated = 0; %how many players migrate each round
world.all_imitated = 0; % how many players imitated each round
world.all_cooperators = world.n_coop; % all n_coop saved over entire game
world.all_defectors = world.n_def; %all n_def saved over entire game


% Let players play game in their Neuman Neighborhood

for round = 1:world.rounds
    migration();
    %NOTE: all changes made by this function are saved in the last_game
    %struct
    
    
    % Update world
%     disp('------ROUND------');
    world.composition = last_game.composition;
    world.payoff = last_game.payoff;
%     disp(world.composition);
%     disp(world.payoff);
    
    %Data Aquisition
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

% disp(world.composition);
total_players = world.all_cooperators+world.all_defectors;
t = [1:world.rounds+1];
pop_comp_plot = figure('Name','Population comparison',...
    'NumberTitle','off','Position',[1000 100 600 600]);
ax2 = axes(pop_comp_plot);
plot(ax2,t,total_players,t,world.all_imitated,t,world.all_cooperators,t,world.all_defectors);
plot_pop(world);
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

