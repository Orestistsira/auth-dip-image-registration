function d = myLocalDescriptor(I, p, rhom, rhoM, rhostep, N)
    %   Calculates the local descriptor for point p.
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
    
    d = zeros(1, numel(rhom:rhostep:rhoM));
    
    % for every circle
    c = 1;
    for r=rhom:rhostep:rhoM
        theta = linspace(0, 2*pi, N);
        points = [p(1) + r * cos(theta); p(2) + r * sin(theta)];

        %plot(points(2,:), points(1,:), 'ro')
        %hold on
        
        % Interpolate pixel values
        interPoints = interp2(double(I), points(2,:), points(1,:), 'linear');
        
        % Calculate mean of interpolated values
        d(c) = mean(interPoints);
        c = c + 1;
    end
    
end

function plotCircle(r, x, y)
    th = 0:pi/50:2*pi;
    xunit = r * cos(th) + x;
    yunit = r * sin(th) + y;
    plot(yunit, xunit, 'r-', 'LineWidth', 2);
end