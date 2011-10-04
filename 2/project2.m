% Team Project 2
%
% 9-27-11
% CPE 428
% Team Spaceman: Jason Dreisbach, Blake Rafter, and Jennifer Tighe



% Part A images 1 & 2

mean = fspecial('average');
gauss = fspecial('gaussian');

boat = imread('Boat2_1.tif');
building = imread('building.gif');

figure(1);
subplot(321); imshow(boat); title('Boat');
subplot(322); imhist(boat); title('histogram');

% TODO: make the median filter work
subplot(323); imshow(medfilt2(boat)); title('median filter');

subplot(324); imshow(myfilter(boat, mean)); title('averaging');


subplot(325); imshow(myfilter(boat, gauss)); title('gaussian');


figure(2);

subplot(321); imshow(building); title('building');
subplot(322); imhist(building); title('histogram');
subplot(323); imshow(medfilt2(building)); title('median filter');
subplot(324); imshow(myfilter(building, mean)); title('averaging');
subplot(325); imshow(myfilter(building, gauss)); title('gaussian');


% Part B - Edge Detection

figure(3); sobel_func('corner_window.jpg');
figure(4); prewitt_func('corner_window.jpg');

figure(5); sobel_func('corridor.jpg');
figure(6); prewitt_func('corridor.jpg');

figure(7); sobel_func('tree.jpg');
figure(8); prewitt_func('tree.jpg');

figure(9); sobel_func('New York City.jpg');
figure(10); prewitt_func('New York City.jpg');












