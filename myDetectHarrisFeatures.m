function corners = myDetectHarrisFeatures(I, Rthres)
    %   Detects points of interest using harris corner detector algorithm.
    %
    %   Input:
    %   - I: The image in grayscale.
    %   - Rthres: Threshold for R variable.
    %
    %   Output:
    %   - corners: A list of the corners' coordinates.

    if ~ismatrix(I)
        error('Image should be grayscale');
    end
    
    % Calculate gradients
    [I1, I2] = imgradientxy(I);

    I1_2 = I1 .* I1;
    I2_2 = I2 .* I2;
    I12 = I1 .* I2;
    
    % Compute Gaussian filter
    sigma = 0.5;
    I1_2 = imgaussfilt(I1_2, sigma);
    I2_2 = imgaussfilt(I2_2, sigma);
    I12 = imgaussfilt(I12, sigma);

    % Compute M matrix elements
    M11 = I1_2;
    M22 = I2_2;
    M12 = I12;

    % Compute the corner response function
    k = 0.05;
    detM = M11 .* M22 - M12 .^ 2;
    traceM = M11 + M22;
    R = detM - k * traceM .^ 2;
    
    % Perform non-maximum suppression
    cornerResponseMax = imregionalmax(R);
    cornerResponseMax = cornerResponseMax & (R > Rthres);
    
    % Get corner coordinates
    [rows, cols] = find(cornerResponseMax);
    corners = [rows, cols];
    
end