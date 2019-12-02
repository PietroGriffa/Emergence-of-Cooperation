function [] = plot_pop(save_image_options,end_flag,round)
% Function that plots the population grid
%
% Input:
%   - save_image_options: structire that specifies the options on how to
%           save the images
%   - end_flag: flag to identify the final plot
%   - round: number of actual round
%
% Output:
%   - Plot of population grid
%
% Color legend:
%   - cooperators:  dark green ([0 1 0.5])
%   - defectors: 	magenta ([1 0 1])
%   - leaders:      blu ([0 0 1])
%   - empty space:  white spaces ([1 1 1])



global world

persistent ax step

if isempty(findobj('type','figure','name','Population'))
    % If figure is not initializated yet, do it
    pop_plot = figure('Name','Population','NumberTitle','off','Position',[200 50 500 500]);
    ax = axes(pop_plot);
    title(ax,'Population')
    axis equal
    axis off
    
    step = 1;
end

map = [ 1   1   1       % free space
        0   1   0.5     % cooperators
        1   0   1       % defectors
        0   0   1];     % leaders

% Make sure the colormap is consistent
if (world.n_leaders == 0) || (world.leadership == 0)
    map(end,:)=[];
elseif  world.all_cooperators(round+1) == 0
    map(2,:) =[];
elseif  world.all_defectors(round+1) == 0
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
title(ax,'Population grid')
%colorbar
axis(ax,'off')
axis equal

ax.Children.LineStyle = 'none';

%% Save images
if save_image_options.only_last && ~save_image_options.all
    if end_flag
        saveas(ax.Parent,save_image_options.image_basename,save_image_options.format_type); 
    end
elseif save_image_options.all
    name = strcat(save_image_options.image_basename,'_',int2str(step));
    %saveas(ax.Parent,name,save_image_options.format_type); 
    saveas(ax.Parent,name,save_image_options.format_type);
    step = step+1;
end


%% Extra
% hold(ax,'on');
% if ~isempty(world.composition)
%     plot(ax,world.composition(2,:)+0.5,world.composition(1,:)+0.5,'or');
% end
% hold(ax,'off');
% drawnow;
% pause(.2);

end     % end function
