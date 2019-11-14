function [] = success_driven_migration(world,migration,player_cord)
% Function that explore the free slots around a focal player and evaluate
% if this one can move to a more profitable area.

% Many ideas are reused from the function neighborhood_watch.m : look at
% this for reference for these first lines.
v = [-migration.M:1:migration.M];
combs = unique(sort(nchoosek(repmat(v,1,k),k),2),'rows');
combs = combs(sum(combs,2)~=0,:);   % remove central point
to_check = player_cord+combs;    % indices of points around focal we want to check
rows = to_check(:,1);       columns = to_check(:,2);
idx2check = sub2ind(size(world.composition),rows,columns);  % switch form coordinates to indices

% Identify free slots
free_slots = world.composition(idx2check);  % strategy of neighboring player
free_slots = neighbors_strategy(neighbors_strategy==0); % identify only free slots

% For each of the free slots, simulate one round of game with neighbors and
% compare expected payoff with the current one: if higher move the new slot





end % end function