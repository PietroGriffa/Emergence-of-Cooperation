function [imitated, imitated_cord, player_cord] = imitate(player_cord)
%   updates the strategy (in world.composition) of the player at idx
%   to the strategy of the highest payoff in its direct neighborhood,
%   if applicable
%
%   Inputs:
%       - player_cord: coordinate of the focal player that wants to imitate
%       strategy
%
%   Output:
%       - imitated: true/false, whether the focal player has indeed
%       imitated a strategy
%       - imitate_coord: the coordinates of the player who's strategy has
%       bin imitated

global world
global game

%% Imitate

if rand>game.p_imitation
    imitated = false;
    imitated_cord = player_cord;

else
%     v = [-game.m:1:game.m];
%     combs = unique(nchoosek(repmat(v,1,2),2),'rows');
combs =[0 -1
        0 1
        1 0
        -1 0
        0 0];
    %might need to do a check for neative subscripts or do boundary conditions
    to_check = player_cord+combs;    % indices of points around focal we want to check
    
    % Boundary conditions
    negative_idxs = to_check<=0;
    to_check(negative_idxs) = world.L - to_check(negative_idxs);
    too_large_idxs = to_check>world.L;
    to_check(too_large_idxs) = -world.L + to_check(too_large_idxs);

    rows = to_check(:,1);       columns = to_check(:,2);
    idx2check = sub2ind(size(world.composition),rows,columns);  % switch form coordinates to indices
    
    sel = zeros(world.L,world.L);       %blank grid
    sel(idx2check) = world.payoff(idx2check);   % creates a matrix as big as the entire grid
    %   but only the neighborhood of the focal player being non-zero
    
    %edge case with all payoffs being 0
    if (sum(sel,'all')==0)
        max_cord = player_cord;
    else
        [~, max_idx] = max(sel(:)); % max_idx is the linear index 
        %   of maximum value in sel and therefore the index of the maximum payoff
        %   in the neighborhood (trash would be the corresponding payoff, can be ignored)

        %world.composition(idx) = world.composition(max_idx);

        [a, b] = ind2sub(size(world.composition),max_idx);
        max_cord = [a b];
    end 
    
    if sum(max_cord==player_cord)==2
        imitated = false;
        imitated_cord = player_cord;
    else
        imitated = true;
        imitated_cord = max_cord;
    end
        
end % end exclusion for probability

end % end function

