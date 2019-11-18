function [payoff] = neighborhood_watch(player_cord)
% Looks around: gets the sum of neighboring payoffs
%
% Inputs:
%   - world: structure with all the info about the evolution of teh system
%   - migration: structure with all the options of interest for the
%           specific type of game
%   - player_cord: coordinates of the focal player
%
% Outputs:
%   - payoff: new payoff of the focal player
%

global world
global game

% We want to observe the neighborhood of size world.m: to identify the
% points in this area we sum to the coordinates of the focal point the
% combinations with repetition of the elements going from -world.m to
% world.m .
v = [-game.m:1:game.m];
combs = unique(sort(nchoosek(repmat(v,1,2),2),2),'rows');
combs = combs(sum(combs,2)~=0,:);   % remove central point

to_check = player_cord+combs;    % indices of points around focal we want to check

negative_idxs = to_check<=0;
to_check(negative_idxs) = world.L - to_check(negative_idxs);
too_large_idxs = to_check>world.L;
to_check(too_large_idxs) = to_check(too_large_idxs) - world.L;

rows = to_check(:,1);       columns = to_check(:,2);
idx2check = sub2ind([world.L world.L],rows,columns);  % switch form coordinates to indices

player_idx = sub2ind(size(world.composition),player_cord(1),player_cord(2));

player_strategy = world.composition(player_idx);    % strategy of focal player
neighbors_strategy = world.composition(idx2check);  % strategy of neighboring player
neighbors_strategy = neighbors_strategy(neighbors_strategy~=0); % remove free slots

sub2sum = [ones(length(neighbors_strategy),1)*player_strategy neighbors_strategy];
idx2sum = sub2ind(size(world.payoff_mat),sub2sum(:,1),sub2sum(:,2));    % switch form coordinates to indices

% The payoff of the focal player is computed as the sum of the payoffs
% resulting from playing with each one of the neighbors a two player
% Prisoner Dilemma.
payoff = sum(world.payoff_mat(idx2sum),'all');
% NOTE: output new payoff for the focal player. Check in what form is the
% output of cellfun.


end