function [] = plot_pop(world)
% Function that plots the population grid
%
% Input:
%   - _____
%
% Output:
%   - grid
%
% Color legend:
%   - cooperators: ____
%   - defectors: ____
%   - loners: ____
%   - empty space: ____


% !!! This is the old function, must be changed depending on what it takes
% as input !!!

if isempty(findobj('type','figure','name','Population'))
    % If figure is not initializated yet, do it
    pop_plot = figure('Name','Population','NumberTitle','off','Position',[1200 100 600 600]);
    title('Population')
    axis equal
    axis off
else
    % If figure is already initializated, it calls it as the most recent
    % one
    figure(findobj('type','figure','name','Population'));
end
pcolor(world.pop_composition);
colorbar
hold on
if ~isempty(world.last_game)
    plot(world.last_game(2,:)+0.5,world.last_game(1,:)+0.5,'or');
end
hold off
drawnow;
pause(.2);

end     % end function