function [H, inlierMatchingPoints, outlierMatchingPoints] = myRANSAC(matchingPoints, points1, points2, r, N)
    %   Finds the transformation H of rotation by angle theta and 
    %   displacement vector d while seperating the matching pairs to 
    %   inliers and outliers.
    %
    %   Input:
    %   - matchingPoints: An array of the matching pairs pointing in points
    %   arrays.
    %   - points1: An array of the detected points' coordinates from first image.
    %   - points2: An array of the detected points' coordinates from second image.
    %
    %   Output:
    %   - H: A struct containing transformation's theta, d and R.
    %   - inlierMatchingPoints: An array of the inlier pairs.
    %   - outlierMatchingPoints: An array of the outlier pairs.

    n = size(matchingPoints, 1);    
    bestInlierMatchingPoints = [];
    bestOutlierMatchingPoints = [];
    bestScore = 0;  % Initialize best score
    bestH = [];  % Initialize best transformation
    
    for i = 1:1:N
        % Step 1: Randomly choose two pairs of points
        indices = randperm(n, 2);
        pair1 = matchingPoints(indices(1), :);
        pair2 = matchingPoints(indices(2), :);
        
        % Calculate transform of 2 pairs
        H = calculateTransformOfPairs(pair1, pair2, points1, points2);

        % Calculate the score as the sum of Euclidean distances
        inlierMatchingPoints = [];
        outlierMatchingPoints = [];
        score = 0;
        for j = 1:n
            if ~ismember(j, indices)
                pair = matchingPoints(j, :);
                P1 = points1(pair(1), :);
                P2 = points2(pair(2), :);
                transformedP1 = H.R * P1' + H.d';
                distance = norm(P2 - transformedP1');
                
                % Classify the pair of points as inliers or outliers
                
                if distance <= r 
                    %if ~ismember(matchingPoints(j, 1), inlierMatchingPoints) && ~ismember(matchingPoints(j, 2), inlierMatchingPoints)
                    inlierMatchingPoints = [inlierMatchingPoints; matchingPoints(j, :)];
                    %end
                    score = score + 1;
                else
                    outlierMatchingPoints = [outlierMatchingPoints; matchingPoints(j, :)];
                end
            end
        end
        
        % Update the best score and transformation if applicable
        if score > bestScore
            bestScore = score;
            bestH = H;
            bestInlierMatchingPoints = inlierMatchingPoints;
            bestOutlierMatchingPoints = outlierMatchingPoints;
        end
    end

    H = bestH;
    inlierMatchingPoints = bestInlierMatchingPoints;
    outlierMatchingPoints = bestOutlierMatchingPoints;
end

function H = calculateTransformOfPairs(pair1, pair2, points1, points2)
    %   Finds the transformation H of rotation by angle theta and 
    %   displacement vector d of 2 pairs of points.
    %
    %   Input:
    %   - pair1: The points' indexes of the first pair.
    %   - pair2: The points' indexes of the second pair.
    %   - points1: An array of the detected points' coordinates from first image.
    %   - points2: An array of the detected points' coordinates from second image.
    %
    %   Output:
    %   - H: A struct containing transformation's theta, d and R.

    % Extract points from pair1
    P1 = points1(pair1(1), :);
    P2 = points2(pair1(2), :);

    % Extract points from pair2
    Q1 = points1(pair2(1), :);
    Q2 = points2(pair2(2), :);
    
    % Step 2: Compute the transformation H defined by the two pairs
    D1 = Q1 - P1;
    D2 = Q2 - P2;
    
    theta = atan2(D2(2), D2(1)) - atan2(D1(2), D1(1));
    R = [cos(theta), -sin(theta); sin(theta), cos(theta)];
    theta = rad2deg(theta);
    d = (P2' - R * P1')';
    
    H = struct('theta', theta, 'd', d, 'R', R);
end
