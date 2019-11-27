function [] = plot_pop()
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



global world

persistent ax

if isempty(findobj('type','figure','name','Population'))
    % If figure is not initializated yet, do it
    pop_plot = figure('Name','Population','NumberTitle','off','Position',[200 50 500 500]);
    ax = axes(pop_plot);
    title('Population')
    axis equal
    axis off
end

map = [ 1 1 1
        0 1 0
        1 0 0
        0 0 1];
    
if (world.n_leaders == 0) || (world.leadership == 0)
    map(end,:)=[];
elseif  world.all_cooperators(world.rounds+1) == 0
    map(2,:) =[];
elseif  world.all_defectors(world.rounds+1) == 0
    map(3,:) =[];
end


mat = world.composition;
mat(world.leaders) = 3;
mat = mat(end:-1:1,:);  % make the matrix upside down so that the representation is correct

%% If using image
% image(mat);
% axis equal

%% If using pcolor
mat = padarray(mat,1,'post');
mat = padarray(mat,[0 1],'post');
colormap(map);
pcolor(ax,mat);
view(ax,2);
colorbar
axis(ax,'off')
axis equal

ax.Children.LineStyle = 'none';


%% Extra
% hold(ax,'on');
% if ~isempty(world.composition)
%     plot(ax,world.composition(2,:)+0.5,world.composition(1,:)+0.5,'or');
% end
% hold(ax,'off');
% drawnow;
% pause(.2);

end     % end function