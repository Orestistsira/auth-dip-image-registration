function descriptors = calculateDescriptorsUpgrade(I, corners, rhom, rhoM, rhostep, N)
    %   Calculates the descriptors of the detected points using the upgraded version.
    %
    %   Input:
    %   - I: The image in grayscale.
    %   - corners: A list of the corners' coordinates.
    %   - rhom: The min radius of the concentric circles.
    %   - rhoM: The max radius of the concentric circles.
    %   - rhostep: The radius step of the concentric circles.
    %   - N: Concentric circles are scanned at 2π/N points.
    %
    %   Output:
    %   - descriptors: A cell array of the corners' upgraded descriptors.

    N1 = length(corners);
    descriptors = cell(N1, 1);

    for i=1:1:N1
        descriptors{i} = myLocalDescriptorUpgrade(I, corners(i, :), rhom, rhoM, rhostep, N);
    end 

end