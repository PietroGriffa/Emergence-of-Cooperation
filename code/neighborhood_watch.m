function [payoff] = neighborhood_watch(player_cords, comp_mat)
% Looks around: gets the sum of neighboring payoffs
%
% Inputs:
%   - player_cord: coordinates of the focal player
%   - comp_mat: the composition matrix, must be adjusted beforehand
%
% Outputs:
%   - payoff: new payoff of the focal player
%

global world
global game
% disp('----------------------------');
% disp(player_cords);
% disp(comp_mat);
% We want to observe the neighborhood of size world.m: to identify the
% points in this area we sum to the coordinates of the focal point the
% combinations with repetition of the elements going from -world.m to
% world.m .
% v = [-game.m:1:game.m];
% combs = unique(nchoosek(repmat(v,1,2),2),'rows');
% combs = combs(sum(abs(combs),2)~=0,:);   % remove central point
    combs =[-1 0
            0 1
            0 -1
            1 0];
to_check = player_cords+combs;    % indices of points around focal we want to check

player_idx = sub2ind([world.L world.L], player_cords(1,1),player_cords(1,2));

% Boundary condiditons
negative_cords = to_check<=0;
to_check(negative_cords) = world.L - to_check(negative_cords);
too_large_cords = to_check>world.L;
to_check(too_large_cords) = to_check(too_large_cords) - world.L;

% Switch form coordinates to indices
rows = to_check(:,1);       columns = to_check(:,2);
idx2check = sub2ind([world.L world.L],rows,columns);

player_strategy = comp_mat(player_idx);    % strategy 
if world.leadership                                             % force leadership
    for e = 1:length(world.leaders)                             % force leadership
        player_strategy(player_idx==world.leaders(e)) = 3;      % force leadership
    end     % end for loop                                      % force leadership
end % end if                                                    % force leadership

neighbors_strategy = comp_mat(idx2check);  % strategy of neighboring player
if world.leadership                                             % force leadership
    for e = 1:length(world.leaders)                             % force leadership
        neighbors_strategy(idx2check==world.leaders(e)) = 3;    % force leadership
    end     % end for loop                                      % force leadership
end % end if                                                    % force leadership

neighbors_strategy = neighbors_strategy(neighbors_strategy~=0); % remove free slots

sub2sum = [ones(length(neighbors_strategy),1)*player_strategy neighbors_strategy];
%disp(sub2sum);  % for debugging purposes
idx2sum = sub2ind(size(world.payoff_mat),sub2sum(:,1),sub2sum(:,2));    % switch form coordinates to indices

% The payoff of the focal player is computed x the sum of the payoffs
% resulting from playing with each one of the neighbors a two player
% Prisoner Dilemma.
payoff = sum(world.payoff_mat(idx2sum),'all');
% NOTE: output new payoff for the focal player. Check in what form is the
% output of cellfun.


end