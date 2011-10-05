% Team Project 2
%
% 9-27-11
% CPE 428
% Team Spaceman: Jason Dreisbach, Blake Rafter, and Jennifer Tighe


% our filter function

%mask must be an odd size square

function [output] = myfilter(input, mask)

% this is the number we need to divide our value
% by after we multiply the mask
div = sum(mask(:));

output = uint8(gfilt(input,mask))/div;

