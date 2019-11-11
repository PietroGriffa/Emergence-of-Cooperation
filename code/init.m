function [world,game] = init(world)
% Function that initialize the problem
%
% Inputs:
%   - world params (structure)
%
% Outputs: 
%   - name of the function to call the game
%   - initialized matrix of population
%   - initialized matrix of payoffs

%% Testing 

%world.n = 25;
%world.N = 10;
%world.L = 6;
%world.p_loners = 0.3;
%world.p_cooperators = 0.5;

%% Initialize Population Matrix

% create population matrix to keep track of which slots are emty or not
slots = zeros(world.L,world.L);  %creates blank LxL grid
slots_permutation = randperm(world.L*world.L, world.n); %chooses n different slot indexes to be populated
slots(slots_permutation) = 1; %sets populated slots to 1, 0 are emty slots


pop_comp = rand(world.L,world.L); % generate random composition in LxL grid
world.composition = 0.5*((pop_comp < world.p_loners) & (slots == 1)) + ...
    1*((pop_comp > 1- world.p_cooperators) & (slots == 1)) + ...
    -1*((pop_comp < 1-world.p_cooperators) & (pop_comp > world.p_loners) & (slots == 1))+ ...
    0*(slots == 0);


% sets only the populated slots (1es in "slots") and only if the random
% value is in the range of the percentile for each strategy given in main

world.n_cooperators = sum(world.composition(:)==1); 
world.n_loners = sum(world.composition(:)==0.5);
world.n_defectors = sum(world.composition(:)==0);

% need to actually count number of players with certain strategy, as there
% is some variance in the distribution

%   0    for empty slot
%   0.5  for loners
%   -1    for defectors
%   1    for cooperators
%   
%plot_pop(world);

%% Initialze Payoff Matrix

game.payoff = zeros(world.L);  % payoff now in an identical grid as the composition
% there are no payoffs before the first game has been played


%% status

disp('initialized composition: ')
disp(world.composition);
disp('initialized payoff: ')
disp(game.payoff)

















%switch world.typeOfGame
    
    % Here we set the type of game we are gonna simulate
    % (If you have any good idea for some new ones, just add the
    % initialization here following the same structure)
    
%    case 'red_queen'
            
        % Name of the function to call later to simulate the game
%        game = str2fun('<NAME OF THE FUCNTION>')
        
        % Initialize a random initial population
        
%        pop_composition = rand(n,n)   % generate random composition
%        pop_composition =  0.5*(pop_composition < world.p_loners) + ...
%            (pop_composition > 1-world.p_cooperators);
        %
        %   0.5 for loners
        %   0   for defectors
        %   1   for cooperators
        
        % The grid in this type of game does not need any free space
        % (We could alternatively keep some free space and simply set the
        % motion to 0)
        
%    case 'migration'
        
        % Name of the function to call later to simulate the game
%        game = str2fun('<NAME OF THE FUCNTION>')
        
%    case 'hybrid'
        
        % It could be fun to mix some different strategies from different
        % papers
        
        % Name of the function to call later to simulate the game
%        game = str2fun('<NAME OF THE FUCNTION>')
        
%    otherwise
        % Default error: worng input name
%        disp('Try an acceptable type of game.');
%end
    






end % end of function