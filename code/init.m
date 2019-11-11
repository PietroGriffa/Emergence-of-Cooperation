function [world, game] = init(world)
% Function that initialize the problem
%
% Inputs:
%   - world params (structure)
%
% Outputs: 
%   - name fo the functionto call the game
%   - initialized matrix of population
%   - initialized matrix of payoffs

switch world.typeOfGame
    
    % Here we set the type of game we are gonna simulate
    % (If you have any good idea for some new ones, just add the
    % initialization here following the same structure)
    
    case 'red_queen'
        
        % Name of the function to call later to simulate the game
        game = str2fun('<NAME OF THE FUCNTION>')
        
        % Initialize a random initial population
        pop_composition = rand(n,n);   % generate random composition
        pop_composition =  0.5*(pop_composition < world.p_loners) + ...
            (pop_composition > 1-world.p_cooperators);
        %
        %   0.5 for loners
        %   0   for defectors
        %   1   for cooperators
        
        % The grid in this type of game does not need any free space
        % (We could alternatively keep some free space and simply set the
        % motion to 0)
        
        %world.pop_composition = pop_composition
        
        
    case 'migration'
        
        % Name of the function to call later to simulate the game
        game = str2fun('<NAME OF THE FUCNTION>')
        
    case 'hybrid'
        
        % It could be fun to mix some different strategies from different
        % papers
        
        % Name of the function to call later to simulate the game
        game = str2fun('<NAME OF THE FUCNTION>')
        
    otherwise
        % Default error: worng input name
        disp('Try an acceptable type of game.');
end
    






end % end of function