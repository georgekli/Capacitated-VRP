function dm = distanceMatrix(coordinates, num)
% Calaculate distance matrix from nodes table using Euclidean distance

dm = zeros(num,num); %init for efficiency
for i = 1:num
    for j = 1:num
    % Perform column wise operations to calculate euclidean distance
    dm(i,j) = sqrt(sum((coordinates(i,:)-coordinates(j,:)).^2,2));
    end
end
end