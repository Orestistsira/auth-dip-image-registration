function d = myLocalDescriptorUpgrade(I, p, rhom, rhoM, rhostep, N)
    %   Calculates the local descriptor for point p using the upgraded version.
    %
    %   Input:
    %   - I: The image in grayscale.
    %   - p: The point's coordinates.
    %   - rhom: The min radius of the concentric circles.
    %   - rhoM: The max radius of the concentric circles.
    %   - rhostep: The radius step of the concentric circles.
    %   - N: Concentric circles are scanned at 2π/N points.
    %
    %   Output:
    %   - d: An array of the point's descriptor.

    if ~ismatrix(I)
        error('Image should be grayscale');
    end
    
    [H, W] = size(I);
    d = [];
    
    if p(1) - rhoM < 0 || p(1) + rhoM > H
        return
    elseif p(2) - rhoM < 0 || p(2) + rhoM > W
        return
    end

    numCircles = numel(rhom:rhostep:rhoM);
    d = zeros(1, numCircles * 2);
    
    % for every circle
    c = 1;
    for r = rhom:rhostep:rhoM
        theta = linspace(0, 2*pi, N);
        points = [p(1) + r * cos(theta); p(2) + r * sin(theta)];
        
        % Interpolate pixel values
        interPoints = interp2(double(I), points(2,:), points(1,:), 'linear');
        
        % Calculate mean and variance of interpolated values
        meanVal = mean(interPoints);
        varVal = var(interPoints);
        
        % Store mean and variance values in descriptor
        startIdx = (c - 1) * 2 + 1;
        endIdx = c * 2;
        d(startIdx:endIdx) = [meanVal, varVal];
        
        c = c + 1;
    end
end
