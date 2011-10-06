% Team Project 2
%
% 9-27-11
% CPE 428
% Team Spaceman: Jason Dreisbach, Blake Rafter, and Jennifer Tighe


% our filter function

%mask must be an odd size square

function [output] = cannyedge(input)

bin_input = im2bw(input);

subplot(331); imshow(input); title('Input Image');
subplot(332); imshow(edge(bin_input, 'canny', 0.5, 0.5)); title('Thresh = 0.5, Sigma = 0.5');
subplot(333); imshow(edge(bin_input, 'canny', 0.5, 1)); title('Thresh = 0.5, Sigma = 1');
subplot(334); imshow(edge(bin_input, 'canny', 0.5, 2)); title('Thresh = 0.5, Sigma = 2');
subplot(335); imshow(edge(bin_input, 'canny', 0.1, 0.5)); title('Thresh = 0.1, Sigma = 0.5');
subplot(336); imshow(edge(bin_input, 'canny', 0.9, 0.5)); title('Thresh = 0.9, Sigma = 0.5');
subplot(337); imshow(edge(bin_input, 'canny', 0.1, 1)); title('Thresh = 0.1, Sigma = 1');
subplot(338); imshow(edge(bin_input, 'canny', 0.9, 2)); title('Thresh = 0.9, Sigma = 2');