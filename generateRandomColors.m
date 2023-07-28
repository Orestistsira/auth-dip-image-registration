function colors = generateRandomColors(n)
    %   Generates n random colors.
    %
    %   Input:
    %   - n: The number of the random colors.
    %
    %   Output:
    %   - colors: An array of n random colors.

    % Preallocate array for colors
    colors = zeros(n, 3);
    
    for i = 1:n
        while true
            % Generate random RGB values between 0 and 1
            r = rand();
            g = rand();
            b = rand();
            
            % Check if the color already exists in the array
            if ~any(ismember(colors(1:i-1, :), [r, g, b], 'rows')) && ~isGray(r, g, b)
                colors(i, :) = [r, g, b];  % Add the color to the array
                break;
            end
        end
    end
end

function isGray = isGray(red, green, blue)
    %   Checks if the color is gray
    %
    %   Input:
    %   - red: The red channel.
    %   - green: The green channel.
    %   - blue: The blue channel.
    %
    %   Output:
    %   - isGray: True if color is Gray, False otherwise.

    isGray = abs(red - green) < 0.1 && abs(red - blue) < 0.1 && abs(green - blue) < 0.1;
end