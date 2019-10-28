function [world] = init(world)
% Function that initialize the problem
%
% Inputs:
%   - world params (structure)
%
% Outputs: 
%   - initialized matrix of population
%   - initialized matrix of payoffs

switch world.typeOfGame
    case 'red_queen'
        
    case 'migration'
        
    case 'hybrid'
        
    otherwise
        disp('Try an acceptable type of game.');
end
    






end % end of function