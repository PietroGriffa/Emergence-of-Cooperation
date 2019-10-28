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
    case 'red_queen'
        game = str2fun('<NAME OF THE FUCNTION>')
        
    case 'migration'
        game = str2fun('<NAME OF THE FUCNTION>')
        
    case 'hybrid'
        game = str2fun('<NAME OF THE FUCNTION>')
        
    otherwise
        disp('Try an acceptable type of game.');
end
    






end % end of function