function matchingPoints = descriptorMatching(descriptors1 , descriptors2 , percentageThreshold)
    %   Matches the detected points' descriptors between the two images
    %   using their euclidean distances.
    %
    %   Input:
    %   - descriptors1: A cell array of the detected points' descriptors 
    %   from first image.
    %   - descriptors2: A cell array of the detected points' descriptors 
    %   from second image.
    %   - percentageThreshold: The percentage of the pairs we return.
    %
    %   Output:
    %   - matchingPoints: The best percentageThreshold matching pairs.

    N1 = length(descriptors1);
    N2 = length(descriptors2);
    
    distances = zeros(N1, N2);

    for i = 1:N1
        for j = 1:N2
            % Calculate Euclidean distances between vectors
            if isempty(descriptors1{i}) || isempty(descriptors2{j})
                distances(i, j) = double(realmax);
            else
                distances(i, j) = norm(descriptors1{i} - descriptors2{j});
            end
        end
    end
    
    % Convert distances matrix to a vector
    distances = reshape(distances, [], 1);
    
    % Sort distances and indexes
    [distances, sortedIndexes] = sort(distances);
    [rowIndexes, colIndexes] = ind2sub([N1, N2], sortedIndexes);
    matchingPoints(1, :) = rowIndexes;
    matchingPoints(2, :) = colIndexes;
    
    % Determine the threshold index
    thresholdIndex = ceil(percentageThreshold * numel(distances) / 100);
    
    % Get the indexes within the threshold
    matchingPoints = matchingPoints(:, 1:thresholdIndex)';
end