clearvars;
close all;

im1 = imread('img/im1.png');
im2 = imread('img/im2.png');

Rthres1 = 1.3;
Rthres2 = 0.8;

createPanorama(im1, im2, Rthres1, Rthres2)
