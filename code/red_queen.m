%% Volunteering as Red Queen Mechanism for Cooperation in Public Goods Games
%
% Recreation of the experiment presented in the omonimous paper.
% The experiment is based on recreating a multiagent prisoner dilemma in
% which it is allowed to the player to not to partecipate, falling on a
% safe "side income"that does not depend on others.
%
% Three strategic types:
%   - cooperators
%   - defectors
%   - loners

%% Tabula rasa
clear all
close all

%% Definition of problem 

n = 100;
param.population = n^2;       % total population
param.p_loners      = 0.45;     % initial percentage of loners
param.p_cooperators = 0.3;      % initial percentage of cooperators
param.p_defectors   = 1-param.p_cooperators-param.p_loners; % initial percentage of defectors
param.n_cooperators = param.population*param.p_cooperators;
param.n_defectors   = param.population*param.p_defectors;
param.n_loners      = param.population*param.p_loners;

param.N = 500;   % number of people offered to play the game

param.r = 3;

%% Initial composition 

game_composition = rand(N,N);   % generate random composition
param.game_composition =  0.5*(game_composition < param.p_loners) + ...
    (game_composition > 1-param.p_cooperators);
%   0.5 for loners
%   0   for defectors
%   1   for cooperators

pop_plot = figure('Name','Population','NumberTitle','off','Position',[1200 100 600 600]);
pcolor(game_composition);
title('Population')
axis equal
colorbar
axis off
hold on


%% Play one game
%game = play_game(param)     % print out the results

%% Game
function game = play_game(param)
%
% Function to simulate one game.
%   Inputs: param structure
%   Output: game structure
%

% NOTE: the sampling mechanism implemented here works only for the first
% game played --> must implement a smarter way!

game_composition = rand(1,param.N);

idx = randi(param.population,param.N);
partecipants = param.game_composition(idx);

loners = (game_composition < param.p_loners);   % select loners
game.n_l = nnz(loners);                         % count loners
players = game_composition(loners~=1);          % eliminate loners from game
game.S = length(players);                       % number of players in current game
if game.S <= 1
    disp('All loners, no players for the game');
else
    cooperators = (game_composition > param.p_loners+param.p_defectors);    % select cooperators
    game.n_c = nnz(cooperators);                % number of cooperators in current game

    % r must be > 1 ==> if all cooperate, they are better off than if all
    % defect.
    game.r = param.r;   % for now it is set externally, then we can change it

    % sigma should be > 0 and < r-1 ==> betetr to loner than in a group of
    % defectors; but better still be in a group of cooperators.
    game.sigma = 0.75*(game.r-1);           % payoff for loners
    game.Pd = game.r*game.n_c/game.S;       % payoff for defectors
    game.Pc = game.Pd-1;                    % payoff for cooperators
    game.payoff = game.Pd*ones(param.N);    
    game.payoff(loners) = game.sigma;
    game.payoff(cooperators) = game.Pc;     % distribution of playoffs between all players
    
    % It can be found that the medium payoff for cooperators is better than
    % the one for defectors (Pc/nc)>(Pd/nd) if nc is between these two
    % values: 
    %   (S*(r + (r^2 - 6*r + 1)^(1/2) + 1))/(4*r)
    %   (S*(r - (r^2 - 6*r + 1)^(1/2) + 1))/(4*r)
    % 
    % "winner" refers who had the best medium payoff between the
    % cooperators or defectors.
    % "best payoff" refers to which of the three categoris had the best
    % medium payoff.
    if game.Pc/game.n_c >= game.Pd/(game.S-game.n_c)
        game.winners = 'cooperators';
        if game.sigma/game.n_l >= game.Pc/game.n_c
            game.best_payoff = 'loners';
        else 
            game.best_payoff = 'cooperators';
        end
    else
        game.winners = 'defectors';
        if game.sigma/game.n_l >= game.Pc/game.n_c
            game.best_payoff = 'loners';
        else 
            game.best_payoff = 'defectors';
        end
    end
    
end

end % end function


