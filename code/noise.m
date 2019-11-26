function [] = noise()
% Implementation of Noise
%
%   
%   for every non empty slot find()
%   if rand < game.p_strat_noise
%       if strateg == 1
%           strategy = 2;
%       else
%           strategy = 1;
%   if rand < game.p_mig_noise
%       find empty slot in neighborhood (same range as migration)
%           find all empty slots in area
%           choose one random slot from list
%       migrate to that slot (update last_game)
%
%   probably need to do the same last_game change as in imitation
%   


%   do the strategy noise first -> don't have to keep track of changed
%   positions
end