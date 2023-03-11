function newRoute = swap(route, i, j)
    % Create new route by swapping nodes i, j and reconnecting
    newRoute = route(1:i);
    % Use reverse order
    newRoute = [newRoute flip(route(i+1:j))];
    newRoute = [newRoute route(j+1:end)];
end