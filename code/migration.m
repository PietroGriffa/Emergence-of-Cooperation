function [] = migration(world,migration)

populatedslots = find(world.composition);
focal_idx = randsample(populatedslots, world.N);

[row,col] = ind2sub(size(world.composition),focal_idx);
mat_players = [row col];

cell_players = mat2cell(mat_players,[ones(1,size(mat_players,1))],[size(mat_players,2)]);


v = [-migration.neighb:1:migration.neighb];
combs = unique(sort(nchoosek(repmat(v,1,k),k),2),'rows');
for i=1:size(combs,1)
    
    
    
end

[row,col] = ind2sub(size(world.composition),idx);

C = combnk(v,k)