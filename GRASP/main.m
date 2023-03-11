% Initialization
clc;
clear all;
close all;
% Solving Capacitated Multi Trip VRP problem stated in problem.txt

% Read problem from txt
filename = 'problem.txt';
[numNodes, capacity, maxTime, servTime, loadTime, coordinates, demand] = readProblem(filename);
% Calculate distance matrix of nodes
dm = distanceMatrix(coordinates, numNodes);
% GRASP Algorithm with 2-opt
best = zeros(1,1000);
bestCost = inf;
for i = 1:1000
    % Constuct initial route
    [route,totalTime] = initialRoute(capacity, maxTime, servTime, loadTime, dm, demand);
    [optRoute, cost] = Opt2(route, capacity, maxTime, servTime, loadTime, dm, demand);
    if cost < bestCost
        bestRoute = optRoute;
        bestCost = cost;
    end
    best(i) = bestCost;
end
% Display Results
plotRoute(bestRoute, coordinates);
disp(['Best GRASP with 2-opt cost :'  num2str(bestCost)]);
disp('For route:');
disp(mat2str(bestRoute));
figure()
plot(best);
title('GRASP with 2-opt');
xlabel('GRASP Iteration');
ylabel('Route Cost');
disp (['Mean best Score is ' num2str(mean(best))]);

% GRASP Algorithm with 1-1 Exchange
best = zeros(1,1000);
bestCost = inf;
for i = 1:1000
    % Constuct initial route
    [route,totalTime] = initialRoute(capacity, maxTime, servTime, loadTime, dm, demand);
    [optRoute, cost] = oneToOneExchange(route, capacity, maxTime, servTime, loadTime, dm, demand);
    if cost < bestCost
        bestRoute = optRoute;
        bestCost = cost;
    end
    best(i) = bestCost;
end
% Display Results
plotRoute(optRoute, coordinates);
disp(['Best GRASP with 1-1 Exchange cost :'  num2str(bestCost)]);
disp('For route:');
disp(mat2str(bestRoute));
figure()
plot(best);
title('GRASP with 1-1 Exchange');
xlabel('GRASP Iteration');
ylabel('Route Cost');
disp (['Mean best Score is ' num2str(mean(best))]);