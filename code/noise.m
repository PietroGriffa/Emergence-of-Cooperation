function [] = noise(player_cords)
% Implementation of Noise
%
%   Input:
%       - players_cords: coordinates of one player
%
%   Output:
%       - changed

%   for every non empty slot find()


global world
global game
global last_game

if rand < game.p_strat_noise
%   disp("noise applied");
  if last_game.composition(player_cords(1,1),player_cords(1,2)) == 1
      last_game.composition(player_cords(1,1),player_cords(1,2)) = 2;
  else
      last_game.composition(player_cords(1,1),player_cords(1,2)) = 1;
  end
end
%   if rand < game.p_mig_noise
%       find empty slot in neighborhood (same range as migration)
%           find all empty slots in area
%           choose one random slot from list
%       migrate to that slot (update last_game)
%
%   probably need to do the same last_game change as in imitation
%   


%   do the strategy noise first -> don't have to keep track of changed
%   positions

end