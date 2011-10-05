% Laplacian of Gaussian filter

function [output] = lapofgauss(input, hsize, stddev)

mask = fspecial('log',hsize,stddev);

grayinput = rgb2gray(input);

output = gfilt(grayinput,mask);
