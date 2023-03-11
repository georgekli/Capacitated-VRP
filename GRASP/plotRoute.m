function plotRoute(route, coords)
    % Used to plot route in scatter plot
    figure();
    hold on;
    scatter(coords(1,1), coords(1,2), "x", "MarkerFaceColor", "red");
    scatter(coords(2:end,1), coords(2:end,2),"MarkerFaceColor", "blue");
    % Route to Coords
    for i=1:size(route,2)
        coordRoute(i,:) = coords(route(i),:);
    end
    colorCode = [0 0 1];
    for i=1:size(coordRoute,1)-1
        plot([coordRoute(i,1) coordRoute(i+1,1)], [coordRoute(i,2) coordRoute(i+1,2)], "Color", colorCode);
        pause(0.05);
        if route(i) == 1
            colorCode = rand(1, 3);
        end
    end
end