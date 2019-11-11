function [] = neighborhood_watch(world, migration,player_idx)
% Looks around: gets the sum of neighboring payoffs

v = [-migration.m:1:migration.m];
combs = unique(sort(nchoosek(repmat(v,1,k),k),2),'rows');

combs = combs(sum(combs,2)~=0,:);

to_check = player_idx+combs;
rows = to_check(:,1);
columns = to_check(:,2);
idx2check = sub2ind(size(world.composition),rows,columns);

player_strategy = world.composition(player_idx);
neighbors_strategy = world.composition(idx2check);
neighbors_strategy = neighbors_strategy(neighbors_strategy~=0);

sub2sum = [ones(length(neighbors_strategy),1)*player_strategy neighbors_strategy];
idx2sum = sub2ind(size(world.payoff_mat),sub2sum(:,1),sub2sum(:,2));

sum_of_payoffs = sum(world.payoff_mat(idx2sum),'all');

end