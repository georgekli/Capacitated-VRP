function [optRoute, cost] = Opt2(route, capacity, maxTime, servTime, loadTime, dm, demand)
    % Use Opt 2 moves to local search best route and optimize cost
    initialCost = routeCost(route, dm, loadTime, servTime, maxTime, capacity, demand);
    flag = 0;
    while 1
        % Do not exchange starting and ending point
        for i=2:size(route,2)-1
            for j=i+1:size(route,2)-1
                % perform 2-opt move
                newRoute = swap(route, i, j);
                % Calculate new Cost
                newCost = routeCost(newRoute, dm, loadTime, servTime, maxTime, capacity, demand);
                % See if its better
                if newCost < initialCost
                    route = newRoute;
                    initialCost = newCost;
                    flag = 1;
                    break;
                end
            end
            % If we found a better route restart
            if flag == 1
                i = 2;
                flag = 0;
            end
        end
        % If we reach this point there is no better 2 opt move
        break;
    end
    optRoute = route;
    cost = initialCost;
end