function Im = myStitch(im1,im2, H)
    %   Stitches 2 images together based on the transformation H for the 
    %   first image.
    %
    %   Input:
    %   - im1: The first image.
    %   - im2: The second image.
    %   - H: A struct containing transformation's theta, d and R.
    %
    %   Output:
    %   - Im: The stitched image.

    im1 = im2double(im1);
    im2 = im2double(im2);
    
    [M1, N1, ~] = size(im1);
    [M2, N2, ~] = size(im2);

    % Calculate the transformed corners of im1
    corners = [0 0; 0 N1; M1 0; M1 N1];
    transformedCorners = zeros(size(corners));
    
    for i=1:size(corners, 1)
        transformedCorners(i, :) = round(H.R * [corners(i, 1), corners(i, 2)]' + H.d');
    end
    
    % Compute the bounding box coordinates
    xCoords = [transformedCorners(:, 1); 1; N2];
    yCoords = [transformedCorners(:, 2); 1; M2];
    
    xmin = min(xCoords);
    ymin = min(yCoords);
    xmax = max(xCoords);
    ymax = max(yCoords);

    % Initialize stitched image
    pad = 10;
    Im = zeros(abs(xmin - xmax) + pad, abs(ymin - ymax) + pad, 3);
    [M, N, ~] = size(Im);
    
    % Set start of the common coordinate system
    start = ceil([M - abs(xmax) - pad/2, N - abs(ymax) - pad/2]);

    % Draw transformed im1
    for i=start(1):start(1)+M1-1
        x = i - start(1) + 1;
        for j=start(2):start(2)+N1-1
            y = j - start(2) + 1;
            
            if x <= M1 && y <= N1
                p = round(H.R * [x, y]' + H.d');
                Im(start(1) + p(1), start(2) + p(2), :) = im1(x, y, :);
            end
        end
    end
    
    % Draw im2
    for i=start(1):start(1)+M2-1
        x = i - start(1) + 1;
        for j=start(2):start(2)+N2-1
            y = j - start(2) + 1;
    
            if x <= M2 && y <= N2
                Im(i, j, :) = im2(x, y, :);
            end
        end
    end
    
    % Filter for "salt and pepper" noise
    Im = medfilt3(Im, [3 3 1]);

end