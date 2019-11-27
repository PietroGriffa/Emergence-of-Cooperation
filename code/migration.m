function [] = migration()
% Implementation of the game. Contains the main migration logic of the game
% and calls additional functions needed.
%
% Three parts:
%   1) play the game and update payoffs
%   2) imitate if imitation is set to True
%   3) migrate if migration is set to True
%
% Inputs:
%   - world: structure with all the info about the evolution of teh system
%   - migration: structure with all the options of interest for the
%     specific type of game
%
% Outputs:
%   - last_game: structure that summarizes the last game played

global world
global game
global last_game

populatedslots = find(world.composition);           % identify populated slots
focal_idx = randsample(populatedslots, world.N);    % sample players from population
focal_idx_nl = focal_idx;

[row,col] = ind2sub(size(world.composition),focal_idx); % find coordinates from index
mat_players = [row col];
cell_players = mat2cell(mat_players,[ones(1,size(mat_players,1))],[size(mat_players,2)]);

if (world.leadership == true)
    for e = 1:length(world.leaders)
        focal_idx_nl(focal_idx_nl==world.leaders(e)) = [];
    end     % end for loop
    [row,col] = ind2sub(size(world.composition),focal_idx_nl); % find coordinates from index
    mat_players = [row col];
    cell_players_nl = mat2cell(mat_players,[ones(1,size(mat_players,1))],[size(mat_players,2)]);
else
    cell_players_nl = cell_players;
end    % end if statement



% Compute new payoffs for players (and update payoff map)
neighborhood_watch_fun =@(p,q) neighborhood_watch(p,world.composition);
last_game.payoff_list = cellfun(neighborhood_watch_fun,cell_players);
last_game.payoff = world.payoff;
last_game.payoff(focal_idx) = last_game.payoff_list;

%% Imitation and migration

% Implement migration policy
if game.migration
    
    % keep track of any slots that have already been "saved" by other
    % players to avoid two players migrating to the same position and
    % mergin into one
    game.occupied_idx = [];
    game.occupied_strat = [];
    
    %apply success_driven_migration on all focal players
    migration_fun =@(p_cord) success_driven_migration(p_cord);
    [migrated_cell, origin_cell, destination_cell, distance_cell] = cellfun(migration_fun, cell_players_nl,'un',0);

    %convert cells back to matrices
    last_game.migrated = cell2mat(migrated_cell);
    origin = cell2mat(origin_cell);
    origin_idx = sub2ind(size(world.composition),origin(:,1),origin(:,2));
    destination = cell2mat(destination_cell);
    destination_idx = sub2ind(size(world.composition),destination(:,1),destination(:,2));
    distance = cell2mat(distance_cell);
    
    
    
    % Remove non migrated terms
    distance = distance(last_game.migrated == 1);
    origin_idx = origin_idx(last_game.migrated == 1);
    destination_idx = destination_idx(last_game.migrated == 1);
    
    
%     disp(last_game.composition);
    % Update last_game.composition
    last_game.composition(destination_idx) = world.composition(origin_idx);
%     disp(last_game.composition);
    last_game.composition(origin_idx) = world.composition(destination_idx);
%     disp(last_game.composition);
    last_game.payoff(origin_idx) = 0;
    last_game.payoff(destination_idx) = world.composition(origin_idx);
   
%     last_game.composition-world.composition   %tests to visualize changes
end

% Implement imitation policy
if game.imitation
    
    %need to change the cell_players, as we don't want a theoretical player
    %in a slot to imitate a strategy, when it has actually already migrated
    %to a different location
    %it is probably easiest to redefine the entire cell_players
    
    if game.migration
        % we want to change the focal players that moved to their new locations
        cell_players_nl = mat2cell(destination,[ones(1,size(destination,1))],[size(destination,2)]);
    end
        
    imitation_fun = @(p_cord) imitate(p_cord);
    [imitated_cell, imitated_cord_cell, player_cord_cell] = cellfun(imitation_fun, cell_players_nl, 'un',0);
    
    % convert cells back to matricies
    last_game.imitated = cell2mat(imitated_cell);
    imitated_cord = cell2mat(imitated_cord_cell);
    player_cord = cell2mat(player_cord_cell);
    imitated_idx = sub2ind(size(world.composition),imitated_cord(:,1),imitated_cord(:,2));
    player_idx = sub2ind(size(world.composition),player_cord(:,1),player_cord(:,2));
    
    %updates strategies in last_game.composition
    to_imitate = find(last_game.imitated);
    imitated_idx = imitated_idx(last_game.imitated == 1);
    last_game.composition(player_idx(to_imitate)) = world.composition(imitated_idx);
    % last_game updated
    
end % end imitation

if game.noise
    noise_fun =@(pc) noise(pc);
    cellfun(noise_fun,cell_players_nl);
end % end noise

end % end function
