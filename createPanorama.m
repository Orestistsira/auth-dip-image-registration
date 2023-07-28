function createPanorama(im1, im2, Rthres1, Rthres2)
    %   Uses the other functions to create a panoramic image of the input
    %   images and show it on screen.
    %
    %   Input:
    %   - im1: The first image.
    %   - im2: The second image.
    %   - Rthres1: The R threshold for the first image.
    %   - Rthres2: The R threshold for the second image.

    % Convert to grayscale and clip to 0-1
    im1_gray = mat2gray(rgb2gray(im1));
    im2_gray = mat2gray(rgb2gray(im2));
    
    rhom = 5; rhoM = 20; rhostep = 1; N=8;
    
    % Image 1
    myCorners1 = myDetectHarrisFeatures(im1_gray, Rthres1);
    descriptors1 = calculateDescriptorsUpgrade(im1_gray, myCorners1, rhom, rhoM, rhostep, N);
    
    % Image 2
    myCorners2 = myDetectHarrisFeatures(im2_gray, Rthres2);
    descriptors2 = calculateDescriptorsUpgrade(im2_gray, myCorners2, rhom, rhoM, rhostep, N);
    
    % Find matching points
    percentageThreshold = 30;
    matchingPoints = descriptorMatching(descriptors1 , descriptors2 , percentageThreshold);
    
    % Find Transform, Inliers and Outliers
    r = 20;
    N = 5000;
    [H, inlierMatchingPoints, outlierMatchingPoints] = myRANSAC(matchingPoints, myCorners1, myCorners2, r, N);
    
    % Stitch images using transform
    im_stitched = myStitch(im1, im2, H);
    
    % Figures
    inlierUniqueMatchingPoints = deleteNonUniqueRows(inlierMatchingPoints);
    outlierUniqueMatchingPoints = deleteNonUniqueRows(outlierMatchingPoints);
    
    colors = generateRandomColors(size(inlierUniqueMatchingPoints, 1));
    grayColor = [.7 .7 .7];
    
    figure
    imshow(im1);
    hold on
    plot(myCorners1(:, 2), myCorners1(:, 1), 'g+')
    hold on
    plot(myCorners1(outlierUniqueMatchingPoints(:, 1), 2), myCorners1(outlierUniqueMatchingPoints(:, 1), 1), 's', 'Color', grayColor, 'LineWidth', 5)
    plotColoredPoints(myCorners1(inlierUniqueMatchingPoints(:, 1), :), colors)
    hold off
    
    figure
    imshow(im2);
    hold on
    plot(myCorners2(:, 2), myCorners2(:, 1), 'g+')
    plot(myCorners2(outlierUniqueMatchingPoints(:, 2), 2), myCorners2(outlierUniqueMatchingPoints(:, 2), 1), 's', 'Color', grayColor, 'LineWidth', 5)
    plotColoredPoints(myCorners2(inlierUniqueMatchingPoints(:, 2), :), colors)
    hold off
    
    figure
    imshow(im_stitched);
end