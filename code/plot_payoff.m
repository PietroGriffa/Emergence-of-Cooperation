function [] = pop_payoff(___)
% Function that plots the payoffs grid
%
% Input:
%   - ___
%
% Output:
%   - grid
%

% !!! This is the old function, must be changed depending on what it takes
% as input !!!


if isempty(findobj('type','figure','name','Payoff'))
    % If figure is not initializated yet, do it
    pop_plot = figure('Name','Payoff','NumberTitle','off','Position',[300 100 600 600]);
    title('Payoff')
    axis equal
    axis off
else
    % If figure is already initializated, it calls it as the most recent
    % one
    figure(findobj('type','figure','name','Payoff'));
end
pcolor(world.payoff);
colorbar
hold on
if ~isempty(world.last_game)
    plot(world.last_game(2,:)+0.5,world.last_game(1,:)+0.5,'or');
end
hold off
drawnow;
pause(.2);


end     % end function 