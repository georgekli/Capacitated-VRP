function cost = routeCost(route, dm, loadTime, servTime, maxTime, capacity, demand)
% Calculate cost of route in time and check if route is feasible. If not
% return inf cost of route
cost = 0;
capacityLeft = capacity;
TOR = 0; %Time on Route
for i=1:size(route,2)-1
    % If we are going to a node other than starting point
    if route(i+1) ~= 1
        % Check if it is safe to reach it
        if (TOR + dm(route(i),route(i+1)) + dm(1,route(i+1)) + servTime < maxTime) && (capacityLeft - demand(route(i+1)) > 0)
            % Reduce capacity left in vehicle
            capacityLeft = capacityLeft - demand(route(i+1));
        else
            % This route is infeasible
            cost = inf;
            break;
        end
        % Update cost and TOR
        cost = cost + dm(route(i),route(i+1)) + servTime;
        TOR = TOR + dm(route(i),route(i+1)) + servTime;
    % We are going to the starting point
    else
        % Check if we can reach it
        if not((TOR + dm(route(i),route(i+1)) < maxTime))
            % This route is infeasible
            cost = inf;
            break;
        end
        % Update capacity and cost
        capacityLeft = capacity;
        TOR = 0;
        cost = cost + dm(route(i),route(i+1)) + loadTime;
    end
end