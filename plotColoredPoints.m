function plotColoredPoints(points, colors)    
    %   Plot each point of points array with a different color from colors
    %   array.
    %
    %   Input:
    %   - points: An array of n points' coordinates.
    %   - colors: An array of n colors.

    for i = 1:size(points, 1)
        point = points(i, :);
        color = colors(i, :);
        plot(point(2), point(1), 's', 'Color', color, 'LineWidth', 5);
    end

    hold on;

end