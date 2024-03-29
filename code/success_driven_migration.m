function [has_migrated, origin, destination, new_payoff] = success_driven_migration(player_cords)
% Function that explore the free slots around a focal player and evaluate
% if this one can move to a more profitable area.
%
%   Inputs:
%       - player_cords: coordinates of one single player
%
%   Outputs:
%       - migrated: whether the playermigrated or not
%       - 


global world
global game

% Since every player has a probability p_migration to migrate in a better
% area, we first sample to understand if it moves, if yes we compute the
% best location to migrate to.
origin = player_cords;

if rand > game.p_migration
    has_migrated = false;
    destination = player_cords;
    new_payoff = 0;
    
else

    % Many ideas are reused from the function neighborhood_watch.m : look at
    % this for reference for these first lines.
    
    v = [-game.M:1:game.M];
    combs = unique(nchoosek(repmat(v,1,2),2),'rows');
    % NOTE: in this case we don't want to remove the central point, as it
    % may be not convenient to migrate
    
    to_check = player_cords+combs;    % coordinates of points around focal we want to check

    % NOTE: we want to order the points from the closest to the furthest from
    % the focal player (in case of two free slots being equally promising, we
    % want to choose the closest one)
    
    player_idx = sub2ind(size(world.composition),player_cords(1,1),player_cords(1,2));
    
    %boundary conditions
    negative_cords = to_check<=0;
    to_check(negative_cords) = world.L - to_check(negative_cords);
    too_large_cords = to_check>world.L;
    to_check(too_large_cords) = -world.L + to_check(too_large_cords);
    %works 
    
    % Convert to linear indexes
    rows = to_check(:,1);       
    columns = to_check(:,2);
    to_check_idx_unsorted = sub2ind(size(world.composition),rows,columns);
    
    
    %order from idx from closest to furthest away
    closeness = vecnorm((player_cords-to_check)');
    [useless,order] = sort(closeness);
    to_check_idx = to_check_idx_unsorted(order);
    
    % Modify the composition to consider slots already chosen by other
    % players to migrate to
    comp_occupied = world.composition;
    comp_occupied(game.occupied_idx) = game.occupied_strat;

    % Identify free slots
    free_slots_idx = to_check_idx(comp_occupied(to_check_idx)==0 |...
        to_check_idx == player_idx); %only a free slot if the strategy at a specific point is 0
    %
    
    if isempty(free_slots_idx)
        % Can't migrate since there are no free slots within the mobility
        % range
        has_migrated = false;
        destination = player_cords;
        new_payoff = 0;
        
    else

        % For each of the free slots, simulate one round of game with neighbors and
        % compare expected payoff with the current one: if higher move the new slot
        [a b] = ind2sub(size(world.composition), free_slots_idx);
        free_slots_cords = [a b];
        slots_cell = mat2cell(free_slots_cords, [ones([size(free_slots_idx,1),1])]);
        player_mat = repmat(player_idx,[size(free_slots_idx),1]);
        player_cell = mat2cell(player_mat, [ones(size(free_slots_idx,1),1)]);
        %works
        
        % calculate expected payoff at each empty slot

        % makes exact copies of composition
        comp_mat = repmat(comp_occupied,[size(free_slots_idx),1]);
        
        comp_cell = mat2cell(comp_mat,[repmat(world.L,[size(slots_cell,1), 1])]);
      
        % apply mod_comp on every composition to simulate migration
        comp_mod_fun =@(h, i, j) mod_comp(h, i, j);
        comp_cell = cellfun(comp_mod_fun, comp_cell, player_cell, slots_cell,'un',0);

        % calculates expeted outcomes at possible migration points
        game_fun =@(slot_cord,composition) neighborhood_watch(slot_cord,composition);  %%neighborhoodwatch takes in coords!!
        expectation = cellfun(game_fun, slots_cell, comp_cell);
        % NOTE: The vector should already be ordered in ascending order starting
        % from the closest slots to the furthest ones
        [best_expectation, best_slot] = max(expectation);

        if best_slot == 1   % means the best choice is to not stay in the same position
            has_migrated = false;
            new_payoff = world.payoff(player_idx);
        else
            has_migrated = true;
            new_payoff = best_expectation;
            
            % save destination as occupied for next round of calculations
            dest_cords = free_slots_cords(best_slot,:);
            dest_idx = sub2ind(size(world.composition),dest_cords(1,1),dest_cords(1,2));
            game.occupied_idx(end+1) = dest_idx;
            game.occupied_strat(end+1) = world.composition(player_idx);
            
        end

        % Best slot to migrate to:
        destination = free_slots_cords(best_slot,:);
        
        % Other statistics:
        %new_payoff =  norm(player_cords-destination);  % distance from orignial position
%         convenience = best_expectation-world.payoff_mat(player_cords);   % how convenient would be to migrate
        
    end     % end check on free slots

end     % end check on chance of migration

end % end function

% switches strategy of player and empty slot to simulate migration
% takes in a composition, a player position and an empty slot position and
% outputs a modified composition with both positions switched
function [modified] = mod_comp(comp, player_idx, slot_cords)
    modified = comp;
    modified(slot_cords(1,1),slot_cords(1,2)) = comp(player_idx);
    modified(player_idx) = comp(slot_cords(1,1),slot_cords(1,2));
end