function [migrated, migrate_to_cord, convenience,distance] = success_driven_migration(world,migration,player_cord)
% Function that explore the free slots around a focal player and evaluate
% if this one can move to a more profitable area.

% Since every player has a probability p_migration to migrate in a better
% area, we first sample to understand if it moves, if yes we compute the
% best location to migrate to.
if rand > migration.p_migration
    migrated = false;
    migrate_to_cord = player_cord;
    convenience = 0;
    distance = 0;
    
else

    % Many ideas are reused from the function neighborhood_watch.m : look at
    % this for reference for these first lines.
    
    v = [-migration.M:1:migration.M];
    combs = unique(sort(nchoosek(repmat(v,1,k),k),2),'rows');
    
    % NOTE: in this case we don't want to remove the central point, as it
    % may be not convenient to migrate
    
    to_check = player_cord+combs;    % indices of points around focal we want to check

    % NOTE: we want to order the points from the closest to the furthest from
    % the focal player (in case of two free slots being equally promising, we
    % want to choose the closest one)
    closeness = vecnorm((plater_coord-to_check)');
    [,order] = sort(closeness);
    to_check = to_check(order);

    rows = to_check(:,1);       columns = to_check(:,2);
    idx2check = sub2ind(size(world.composition),rows,columns);  % switch form coordinates to indices

    % Identify free slots
    free_slots = world.composition(idx2check);  % strategy of neighboring player
    free_slots = neighbors_strategy(neighbors_strategy==0); % identify only free slots
    
    if isempty(free_slots)
        % Can't migrate since there are no free slots within the mobility
        % range
        migrated = false;
        migrate_to_cord = player_cord;
        convenience = 0;
        distance = 0;
        
    else

        % For each of the free slots, simulate one round of game with neighbors and
        % compare expected payoff with the current one: if higher move the new slot
        slots_cell = mat2cell(free_slots,ones(1,size(free_slots,1)),...
        ones(1,size(free_slots,2))); % convert to cell to apply cellfun
        game_fun =@(slot_idx) neighborhood_watch(world, migration,slot_idx);
        expectation = cellfun(game_fun,slots_cell);
        % NOTE: The vector should already be ordered in ascending order starting
        % from the closest slots to the furthest ones
        [best_expectation, best_slot] = max(expectation);

        if best_slot == 1   % means the best choice is to not stay in the same position
            migrated = false
        else
            migrated = true
        end

        % Best slot to migrate to:
        migrate_to_idx = free_slots(best_slot);     % as index
        migrate_to_cord = ind2sub(size(world.composition),migrate_to_idx);  % as coordinates

        % Other statistics:
        distance =  norm(player_cord-migrate_to_cord);  % distance from orignial position
        convenience = best_expectation-world.payoff_mat(player_cord);   % how convenient would be to migrate
        
    end     % end check on free slots

end     % end check on chance of migration

end % end function