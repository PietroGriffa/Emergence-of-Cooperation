function [world,game] = play_round(world, game)
%% Testing Setup


%select focal players
%world.n = 8;
%world.N = 4;
%world.L = 5;
%world.M = 8;
%world.loners = true;
%world.p_loners = 0.5;
%world.p_cooperators = 0.25;
%world.sigma = 0.5;
%world.r = 1.8;
%[world, game] = init(world);

%for testing
%world.composition = zeros(world.L,world.L);
%world.composition(2:4,2:4) = 0.5;
%world.composition(3,3) = 1;
%world.composition(5,1) = 1;
%disp 'world.composition:'
%disp(world.composition)


%% Choose Focal Players
populatedslots = find( world.composition ~= 0); %indexes the populated (not empty) slots
focalidx = randsample(populatedslots, world.N); % select N individual random focal players from populated slots
%focalidx = [17 8 5 18].';                   %testing
%focalgrid = zeros(world.L,world.L);
%focalgrid(focalidx) = 1; %creates LxL matrix where 1 denotes the selected focal players

%% Calculate Payoffs

disp 'focal indexes:'                           %testing
disp(focalidx.')                                %testing
%disp 'initial payoff'                           %testing
%disp(game.payoff)                               %testing
if world.loners == true
    for idx = focalidx.'       %for each of the focal players
        %disp('#####LOOP#####');                 %testing
        %disp('current idx:');
        %disp(idx);
        if world.M == 4 %Neighborhood of four
            %to be done, quite similar to 8, could also just skip it
        elseif  world.M == 8 % Neighborhood of 8 
            [row,col] = ind2sub(size(world.composition),idx); %converts linear index to row and column values
            %disp 'row and col:'                 %testing
            %disp([row, col]);                   %testing
            %define Neighborhood area and apply boundary conditions if out
            %of (matrix) bounds
            %Basically if the focal player is at an edge, some of its
            %neighbors will be at the other end of the field, like when you
            %play "snake" without the border
            %
            %Begin boundary conditions
            if row == 1      %row 
                rowmin = world.L;
            else
                rowmin = row-1;
            end
            if row == world.L
                rowmax = 1;
            else
                rowmax = row+1;
            end

            if col == 1      %column
                colmin = world.L;
            else
                colmin = col-1;
            end
            if col == world.L
                colmax = 1;
            else
                colmax = col+1;
            end
            
            %disp('rows and cols');             %testing
            %disp([rowmin row rowmax; colmin col colmax]);  %testing
            %end boundary conditions
            %
            %count number of cooperators and defectors
            neighborhood = world.composition([rowmin row rowmax],[colmin col colmax]); %compostition of players around the focal player
            disp('current neighborhood');
            disp(neighborhood);
            n_c = sum(neighborhood(:) == 1);
            n_d = sum(neighborhood(:) == -1);
            n_l = sum(neighborhood(:) == 0.5);
            
            %calculate defector payoff
            p_d = world.r*n_c/(n_c+n_d);
            %calculate cooperator payoff
            p_c = p_d-1;
            
            %disp('payoffs (l d c)');               %testing
            %disp([world.sigma p_d p_c]);           %testing
            
            
            % maybe we should only assign the payoff to the actual focal
            % player???
            %
            %applies payoff to focal player according to its strategy
            if world.composition(idx) == 0.5
                game.payoff(idx) = world.sigma;
            elseif world.composition(idx) == -1
                game.payoff(idx) = p_d;
            elseif world.composition(idx) == 1
                game.payoff(idx) = p_c;
            elseif world.composition == 0
                disp('ERROR: an empty slot was chosen as a focal player');
                return;
            end
            %disp('world.composition');                      %testing
            %disp(world.composition);                        %testing
            %update the focal players strategy
           
            
            max_payoff = max([world.sigma p_d p_c]);
           
            if max_payoff == world.sigma 
                disp('the loners won');
            elseif max_payoff == p_d
                disp('the defectors won');
            elseif max_payoff == p_c
                disp('the cooperators won');
            end    
            
            if max_payoff == world.sigma 
                world.composition(idx) = 0.5;
            elseif max_payoff == p_d
                world.composition(idx) = -1;
            elseif max_payoff == p_c
                world.composition(idx) = 1;
            else
                disp('ERROR: something went wrong with the strategy update');
                return
            end
            
            %disp 'current status:'                   %testing
            %disp('current payoff');
            %disp(game.payoff)                       %testing
            disp('current composition');
            disp(world.composition);
            
            %assigns sigma payoff to all loners, cooperators and defectors in neighborhood
            %we don't actually want that because payoffs will be
            %overwritten if we have overlapping neighborhoods
            %code:
            %game.payoff([rowmin row rowmax],[colmin col colmax]) = ...
            %world.sigma*(world.composition([rowmin row rowmax],[colmin col colmax]) == 0.5) + ...
            %p_d*(world.composition([rowmin row rowmax],[colmin col colmax]) == -1) + ...
            %p_c*(world.composition([rowmin row rowmax],[colmin col colmax]) == 1);
            
          
        end
    end
else 
    %use prisoners dilemma formula
end
%disp 'final payoff'                                %testing
%disp(game.payoff)                                  %testing

disp('#####END ROUND#####');




%% PSEUDO:
    %red queen:
%at each focal player apply to neighborhood    
    % what about boundary conditions?
%give loners payoff sigma
%calculate payoff for defectors and cooperators
%if focal player wasn't in the group with the highest payoff, switch the
%strategy to the highest payoff
    %more precise:
%for each entry in focalp with a 1, in a range defined by the Nn
%if its a loner give them payoff sigma
%else count defectors, count cooperators
%calculate p_defectors, p_cooperators ; p_d = r*n_c/(n_c+n_d), p_c = p_d-1
%find winning strategy, switch focalp to winning strategy

    %prisoners dilemma:
%at each focal player apply to neighborhood
%"play" with each neighbor, aka give out payoffs depending on strategy
%combination
%calculate total payoff (do we average or just sum?)
%compare with total payoff of neighbors (from when they last played) and
%switch to strategy with the highest payoff if applicable
    %more precise




%in red queen, all of the N individuals play one game
%in the Helbling paper they only play in their direct Neighborhood

%how about we use a true/false matrix for indexing, it makes it easier 


%for each player
%get strategies of Nn players
%compute payoff with each neighbor
%compute overall payoff


