clearvars;
close all;

im1 = imread('img/imForest1.png');
im2 = imread('img/imForest2.png');

Rthres1 = 0.045;
Rthres2 = 0.035;

createPanorama(im1, im2, Rthres1, Rthres2)
