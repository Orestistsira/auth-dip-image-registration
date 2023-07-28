function [d, d_rot1, d_rot2] = showDescriptorRotation(im_gray, p, theta1, theta2, upgraded)
    %   Tests the descriptors while rotating the image.
    %
    %   Input:
    %   - im_gray: The image in grayscale.
    %   - p: The point to calculate the descriptor.
    %   - theta1: The first angle to rotate the image.
    %   - theta2: The second angle to rotate the image.
    %   - upgraded: True when we want to use the upgraded descripotor 
    %   function, False otherwise.
    %
    %   Output:
    %   - d: The descriptor of the point.
    %   - d_rot1: The descriptor of the point after first rotation.
    %   - d_rot2: The descriptor of the point after second rotation.

    rhom = 5; rhoM = 20; rhostep = 1; N=8;

    figure
    imshow(im_gray);
    hold on
    plot(p(2), p(1), 'g+')
    hold on

    if upgraded
        d = myLocalDescriptorUpgrade(im_gray, p, rhom, rhoM, rhostep, N);
        title('myLocalDescriptorUpgrade, theta = 0')
    else
        d = myLocalDescriptor(im_gray, p, rhom, rhoM, rhostep, N);
        title('myLocalDescriptor, theta = 0')
    end

    % Rotate theta1
    im_rot = imrotate(im_gray, theta1);
    theta1 = deg2rad(theta1);
    R = [cos(theta1), -sin(theta1); sin(theta1), cos(theta1)];
    ImCenterA = (size(im_gray,1,2)/2)';         % Center of the main image
    ImCenterB = (size(im_rot,1,2)/2)';  % Center of the transformed image
    p_rot = R * (p - ImCenterA) + ImCenterB;
    
    figure
    imshow(im_rot);
    hold on
    plot(p_rot(2), p_rot(1), 'g+')
    hold on
    
    if upgraded
        d_rot1 = myLocalDescriptorUpgrade(im_rot, p_rot, rhom, rhoM, rhostep, N);
        title(['myLocalDescriptorUpgrade, theta = ', num2str(rad2deg(theta1))])
    else
        d_rot1 = myLocalDescriptor(im_rot, p_rot, rhom, rhoM, rhostep, N);
        title(['myLocalDescriptor, theta = ', num2str(rad2deg(theta1))])
    end

    % Rotate theta1
    im_rot = imrotate(im_gray, theta2);
    theta2 = deg2rad(theta2);
    R = [cos(theta2), -sin(theta2); sin(theta2), cos(theta2)];
    ImCenterA = (size(im_gray,1,2)/2)';         % Center of the main image
    ImCenterB = (size(im_rot,1,2)/2)';  % Center of the transformed image
    p_rot = R * (p - ImCenterA) + ImCenterB;
    
    figure
    imshow(im_rot);
    hold on
    plot(p_rot(2), p_rot(1), 'g+')
    hold on
    
    if upgraded
        d_rot2 = myLocalDescriptorUpgrade(im_rot, p_rot, rhom, rhoM, rhostep, N);
        title(['myLocalDescriptorUpgrade, theta = ', num2str(rad2deg(theta2))])
    else
        d_rot2 = myLocalDescriptor(im_rot, p_rot, rhom, rhoM, rhostep, N);
        title(['myLocalDescriptor, theta = ', num2str(rad2deg(theta2))])
    end
end