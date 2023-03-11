function [route, totalTime] = initialRoute(capacity, maxTime, servTime, loadTime, dm, demand)
    % Find an initial route based on nearest neighbour approach
    % Starting point is node 1
    rclSize = 4; % Size of Restricted Candidate List
    route = [1];
    passedEveryNode = 0;
    totalTime = 0; % Total time
    TOR = 0; % Time on route
    TTS = 0; % Time to reach starting node
    capacityLeft = capacity; % Items left in the vehicle
    while (not(passedEveryNode))
        nodeNow = route(:,end);
        nodesToGo = dm(:,nodeNow);
        % Remove nodes already visited
        for j=1:size(route,2)
            nodesToGo(route(j)) = 10000;
            % Give a large distance to go in order to not visit it again
        end
        % Find the Restricted Candidate List
        nodePicked = 0;
        while not(nodePicked)
            [nodesSorted, index] = sort(nodesToGo);    
            rcl = index(1:rclSize);
            indexToGo = randi(min(size(nodesToGo,1), rclSize));
            nodeToGo = rcl(indexToGo);
            % Check if we can go there
            if (TOR + dm(nodeNow,nodeToGo) + dm(1,nodeToGo) + servTime < maxTime) && (capacityLeft - demand(nodeToGo) > 0)
                route = [route nodeToGo];
                TTS = dm(1,nodeToGo);
                TOR = TOR + servTime + dm(nodeNow,nodeToGo);
                capacityLeft = capacityLeft - demand(nodeToGo);
                totalTime = totalTime + servTime + dm(nodeNow,nodeToGo);
                nodePicked = 1;
            else
                nodesToGo(nodeToGo) = 10000;
            end
            % Check if we tried to visit every node then go to home
            if all(nodesToGo > 1000)
                % Return home
                totalTime = totalTime + TTS + loadTime;
                capacityLeft = capacity;
                TOR = 0;
                route = [route 1];
                nodePicked = 1;
            end
        end
        % Check if we visited every node
        if size(intersect(route, [1:51]),2) == size(dm,1)
            passedEveryNode = 1;
            % Return home
            totalTime = totalTime + TTS + loadTime;
            capacityLeft = capacity;
            TOR = 0;
            route = [route 1];
        end
    end
end