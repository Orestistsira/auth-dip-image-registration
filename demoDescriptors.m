clearvars;
close all;

im1 = imread('img/im1.png');

% Convert to grayscale and clip to 0-1
im1_gray = mat2gray(rgb2gray(im1));

p1 = [100, 100];
q1 = [200, 200];
q2 = [202, 202];
theta1 = 30;
theta2 = 180;
rhom = 5; rhoM = 20; rhostep = 1; N=8;

% myLocalDescriptor
upgraded = false;
[d, d_rot1, d_rot2] = showDescriptorRotation(im1_gray, p1, theta1, theta2, upgraded);

dq1 = myLocalDescriptor(im1_gray, q1, rhom, rhoM, rhostep, N);
dq2 = myLocalDescriptor(im1_gray, q2, rhom, rhoM, rhostep, N);

% myLocalDescriptorUpgrade
upgraded = true;
[d_upgrade, d_rot1_upgrade, d_rot2_upgrade] = showDescriptorRotation(im1_gray, p1, theta1, theta2, upgraded);

dq1_upgrade = myLocalDescriptor(im1_gray, q1, rhom, rhoM, rhostep, N);
dq2_upgrade = myLocalDescriptor(im1_gray, q2, rhom, rhoM, rhostep, N);
