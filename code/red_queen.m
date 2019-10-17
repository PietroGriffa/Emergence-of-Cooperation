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

%global world

n = 100;
world.population = n^2;       % total population
world.p_loners      = 0.45;     % initial percentage of loners
world.p_cooperators = 0.3;      % initial percentage of cooperators
world.p_defectors   = 1-world.p_cooperators-world.p_loners; % initial percentage of defectors
world.n_cooperators = world.population*world.p_cooperators;
world.n_defectors   = world.population*world.p_defectors;
world.n_loners      = world.population*world.p_loners;

world.N = 500;   % number of people offered to play the game
world.last_game = zeros(2,world.N); % as long no game is played, there is no player

world.r = 3;
% sigma should be > 0 and < r-1 ==> better to loner than in a group of
% defectors; but better still be in a group of cooperators.
world.sigma = 0.75*(world.r-1);     % payoff for loners

%% Initial composition 

% Initialize a random initial population
pop_composition = rand(n,n);   % generate random composition
world.pop_composition =  0.5*(pop_composition < world.p_loners) + ...
    (pop_composition > 1-world.p_cooperators);
%
%   0.5 for loners
%   0   for defectors
%   1   for cooperators
%
% Plot population composition
plot_pop(world);


% Initialize all starting payoff at zero
world.payoff = zeros(n,n);
%
% an alternative may be initializate all the payoffs to sigma, and change
% only the payoffs of cooperators and defectors
%
% Plot payoffs
plot_payoff(world);


pause(1)    % want to wait to see correct update of plots

%% Play one game
[game, world] = play_game(world)     % print out the results

plot_pop(world)
plot_payoff(world);

%% Game
function [game, world] = play_game(world)
%
% Function to simulate one game.
%   Inputs: world structure
%   Output: game structure
%

% NOTE: the sampling mechanism implemented here works only for the first
% game played --> must implement a smarter way!

% select N people to play the game
idx = randi(world.population,[1 world.N]);
world.last_game = [ mod(idx,sqrt(world.population))
                    ceil(idx/sqrt(world.population))]; % partecipants in most recent game
partecipants = world.pop_composition(idx);

game.payoff = zeros(1,world.N);     % initialize payoff at zero for everyone

defectors   = partecipants==0 ;     % identify defectors
loners      = partecipants==0.5 ;   % identify loners
cooperators = partecipants==1 ;     % identify cooperators
players = defectors+cooperators;   % loners are not playing

game.n_l = sum(loners);  % number of loners in the game
game.n_c = sum(cooperators);    % number of cooperators in the game
game.n_d = world.N-game.n_l-game.n_c;     % number of defectors in the game
game.S = game.n_d + game.n_c;       % number of players

% DEBUG
if sum(players)~=game.S          % extra check 
    disp('Something went wrong');
end

if game.S <= 1      % if there is only one non-loner, this is considered as loner too
    disp('All loners, no players for the game');
    game.payoff = world.sigma*ones(world.N);  % everyone gets teh loners' payoff
else
    game.Pd = world.r*game.n_c/game.S;       % payoff for defectors
    game.Pc = game.Pd-1;                    % payoff for cooperators
    
    % Set payoffs
    game.payoff(defectors) = game.Pd;
    game.payoff(loners) = world.sigma;
    game.payoff(cooperators) = game.Pc;
    
    world.payoff(idx) = game.payoff;        % update distribution of payoffs in entire population
    
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
        if world.sigma/game.n_l >= game.Pc/game.n_c
            game.best_payoff = 'loners';
        else 
            game.best_payoff = 'cooperators';
        end
    else
        game.winners = 'defectors';
        if world.sigma/game.n_l >= game.Pc/game.n_c
            game.best_payoff = 'loners';
        else 
            game.best_payoff = 'defectors';
        end
    end
    
end

end % end function

%% Plots
function [] = plot_pop(world)

if isempty(findobj('type','figure','name','Population'))
    % If figure is not initializated yet, do it
    pop_plot = figure('Name','Population','NumberTitle','off','Position',[1200 100 600 600]);
    title('Population')
    axis equal
    axis off
else
    % If figure is already initializated, it calls it as the most recent
    % one
    figure(findobj('type','figure','name','Population'));
end
pcolor(world.pop_composition);
colorbar
hold on
if ~isempty(world.last_game)
    plot(world.last_game(2,:)+0.5,world.last_game(1,:)+0.5,'or');
end
hold off
drawnow;
pause(.2);
    
end     % end plot_pop

function [] = plot_payoff(world)

if isempty(findobj('type','figure','name','Payoff'))
    % If figure is not initializated yet, do it
    pop_plot = figure('Name','Payoff','NumberTitle','off','Position',[300 100 600 600]);
    title('Payoff')
    axis equal
    axis off
else
    % If figure is already initializated, it calls it as the most recent
    % one
    figure(findobj('type','figure','name','Payoff'));
end
pcolor(world.payoff);
colorbar
hold on
if ~isempty(world.last_game)
    plot(world.last_game(2,:)+0.5,world.last_game(1,:)+0.5,'or');
end
hold off
drawnow;
pause(.2);
    
end     % end plot_payoff
