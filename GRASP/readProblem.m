function [numNodes, capacity, maxTime, servTime, loadTime, coordinates, demand] = readProblem(filename)
    % Function to store data imported from txt
    data = importdata(filename); %reading of the text
    numNodes = double(data(1));
    capacity = double(data(2));
    maxTime = double(data(3));
    servTime = double(data(4));
    loadTime = double(data(5));
    
    % Read coordinates
    y = 1;
    j = 0;
    goNext = 1;
    % Store every 2nd and 3rd number as coords
    for (i=6:158)
        if (j ~= 0)
            if (goNext)
                % Store x
                coordinates(y,1) = data(i);
                goNext = 0;
            else
                % Store y
                coordinates(y,2) = data(i);
                goNext = 1;
                y = y + 1; % Go to next coord
            end
        end
        j = j + 1;
        j = mod(j,3);
    end
    
    % Read demand
    y = 1;
    j = 0;
    % Store every 2nd and 3rd number as coords
    for (i=159:261)
        if (j == 1)
            demand(y) = data(i);
            y = y + 1;
        end
        j = j + 1;
        j = mod(j,2);
    end
end