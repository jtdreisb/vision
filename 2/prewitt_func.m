% Team Project 2
%
% 10-4-11
% CPE 428
% Team Spaceman: Jason Dreisbach, Blake Rafter, and Jennifer Tighe


% our filter function

%mask must be an odd size square

function [] = prewitt_func(input)

image = imread(input);
image_bw = rgb2gray(image);

subplot(321); imshow(image_bw); title('Input Image');

%Horizontal and Vertical Prewitt Edge Detectors
prewitt_h = [-1,-1,-1;0,0,0;1,1,1;];
prewitt_v = [-1,0,1;-1,0,1;-1,0,1;];

%Filtering the image using Prewitt Edge Detectors
prewitt_hfilter = myedgefilter(image_bw, prewitt_h);
prewitt_vfilter = myedgefilter(image_bw, prewitt_v);

% Part (b) The Mean Square Gradient Magnitude
prewitt_filter = prewitt_hfilter.*prewitt_hfilter + prewitt_vfilter.*prewitt_vfilter;

prewitt_max_gradient = max(prewitt_filter(:));
prewitt_filter_gray = uint8(255/prewitt_max_gradient * prewitt_filter);

subplot(322); imshow(prewitt_filter_gray); title('Prewitt Mean Square Gradient');

% Part (c) Top 5% of (b) 
p_filter = im2bw(prewitt_filter_gray, .05);

subplot(323); imshow(p_filter); title('Top 5% Prewitt Mean Square Gradient');

% Part (d) Sum of the absolute values of the two mask responses
prewitt_sum = abs(prewitt_hfilter) + abs(prewitt_vfilter);
prewitt_sum_max_gradient = max(prewitt_sum(:));
prewitt_sum_filter_gray = uint8(255/prewitt_sum_max_gradient * prewitt_sum);

subplot(324); imshow(prewitt_sum_filter_gray); title('Sum of abs of Prewitt Masks');

% Part (e) Top 5% of (d)
prewitt_sum_filter = im2bw(prewitt_sum_filter_gray, .05);

subplot(325); imshow(prewitt_sum_filter); title('Top 5% Sum of abs of Prewitt Masks');

end
