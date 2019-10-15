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

param.population = 10000;
param.p_loners      = 0.45;
param.p_cooperators = 0.3;
param.p_defectors   = 1-param.p_cooperators-param.p_loners;
param.n_cooperators = param.population*param.p_cooperators;
param.n_defectors   = param.population*param.p_defectors;
param.n_loners      = param.population*param.p_loners;

param.N = 500;   % number of people offered to play the game

param.r = 3;

%% Play one game
game = play_game(param)     % print out the results

%% Game
function game = play_game(param)
%
% Function to simulate one game.
%   Inputs: param structure
%   Output: game structure
%

game_composition = rand(1,param.N);
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
    game.sigma = 0.75*(game.r-1);
    game.Pd = game.r*game.n_c/game.S;
    game.Pc = game.Pd-1;
    game.payoff = game.Pd*ones(param.N);
    game.payoff(loners) = game.sigma;
    game.payoff(cooperators) = game.Pc;
    
    % It can be found that the medium payoff for cooperators is better than
    % the one for defectors (Pc/nc)>(Pd/nd) if nc is between these two
    % values: 
    %   (S*(r + (r^2 - 6*r + 1)^(1/2) + 1))/(4*r)
    %   (S*(r - (r^2 - 6*r + 1)^(1/2) + 1))/(4*r)
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


