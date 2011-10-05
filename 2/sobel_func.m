% Team Project 2
%
% 10-4-11
% CPE 428
% Team Spaceman: Jason Dreisbach, Blake Rafter, and Jennifer Tighe


% Sobel Filter

function [] = sobel_func(image)

image_gray = rgb2gray(image);

%Horizontal and Vertical Sobel Edge Detectors
sobel_h = [-1,-2,-1;0,0,0;1,2,1;];
sobel_v = [-1,0,1;-2,0,2;-1,0,1;];

%Filtering the image using Sobel Edge Detectors
sobel_hfilter = myedgefilter(image_gray, sobel_h);
sobel_vfilter = myedgefilter(image_gray, sobel_v);

% Part (b) The Mean Square Gradient Magnitude
sobel_filter = sobel_hfilter.*sobel_hfilter + sobel_vfilter.*sobel_vfilter;

sobel_max_gradient = max(sobel_filter(:));
sobel_filter_gray = uint8(255/sobel_max_gradient * sobel_filter);

% Part (c) Top 5% of (b) 
s_filter = im2bw(sobel_filter_gray, .05);

% Part (d) Sum of the absolute values of the two mask responses
sobel_sum = abs(sobel_hfilter) + abs(sobel_vfilter);
sobel_sum_max_gradient = max(sobel_sum(:));
sobel_sum_filter_gray = uint8(255/sobel_sum_max_gradient * sobel_sum);

% Part (e) Top 5% of (d)
sobel_sum_filter = im2bw(sobel_sum_filter_gray, .05);


%Print the image filtered using Sobel Edge Detectors
subplot(321); imshow(image_gray); title('Input Image');
subplot(322); imshow(sobel_filter_gray); title('Sobel Mean Square Gradient');
subplot(323); imshow(s_filter); title('Top 5% Sobel Mean Square Gradient');
subplot(324); imshow(sobel_sum_filter_gray); title('Sum of abs of Sobel Masks');
subplot(325); imshow(sobel_sum_filter); title('Top 5% Sum of abs of Sobel Masks');

end
