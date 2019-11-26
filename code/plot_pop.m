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

persistent ax

if isempty(findobj('type','figure','name','Population'))
    % If figure is not initializated yet, do it
    pop_plot = figure('Name','Population','NumberTitle','off','Position',[200 100 600 600]);
    ax = axes(pop_plot);
    title('Population')
    axis equal
    axis off
end
map = [ 1 1 1
        0 1 0
        1 0 0];
mat = padarray(world.composition,1,'pre');
mat = padarray(mat,[0 1],'post');
pcolor(ax,world.composition);
% surf(world.composition,map)
view(ax,2);
colorbar
hold(ax,'on');
if ~isempty(world.composition)
    plot(ax,world.composition(2,:)+0.5,world.composition(1,:)+0.5,'or');
end
hold(ax,'off');
% drawnow;
pause(.2);

end     % end function