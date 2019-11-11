function [] = migration(world,migration)
% Implementation of the migration game.
%
% Inputs:
%   - world: structure with all the info about the evolution of teh system
%   - migration: structure with all the options of interest for the
%           specific type of game
%
% Outputs:
%

populatedslots = find(world.composition);   % identify populated slots
focal_idx = randsample(populatedslots, world.N); % sample players from population

[row,col] = ind2sub(size(world.composition),focal_idx); % find coordinates from index
mat_players = [row col];

% Convert the matrix of the coordinates of the players for the game in a
% cell array (num_players x 1).
% (This way we can call the function to compute the new payoff easily for
% all players through cellfun).
cell_players = mat2cell(mat_players,[ones(1,size(mat_players,1))],[size(mat_players,2)]);

% Compute new payoffs for players (and update payoffs map)
game_fun =@(p_idx) neighborhood_watch(world, migration,p_idx);
playoffs = cellfun(game_fun,cell_players);
    
    
end
