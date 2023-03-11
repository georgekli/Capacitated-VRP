function [optRoute, cost] = oneToOneExchange(route, capacity, maxTime, servTime, loadTime, dm, demand)
    % Use 1-1 Exchange to perform local search of best route and optimize cost
    flag = 0;
    initialCost = routeCost(route, dm, loadTime, servTime, maxTime, capacity, demand);
    while 1
        % Do not exchange starting and ending point
        for i=2:size(route,2)-1
            for j=i+1:size(route,2)-1
                newRoute = route;
                % Exchange nodes in route
                newRoute(i) = route(j);
                newRoute(j) = route(i);
                % Calculate new cost
                newCost = routeCost(newRoute, dm, loadTime, servTime, maxTime, capacity, demand);
                % See if the cost is improved
                if newCost < initialCost
                    route = newRoute;
                    initialCost = newCost;
                    flag = 1;
                    break;
                end
            end
            % Restart local search
            if flag == 1
                i = 2;
                flag = 0;
            end
        end
        % If we reach this point not further improvement can be made
        break;
    end
    optRoute = route;
    cost = initialCost;
end