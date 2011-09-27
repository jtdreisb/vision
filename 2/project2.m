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

subplot(324); imshow(imfilter(boat, mean)); title('averaging');


subplot(325); imshow(imfilter(boat, gauss)); title('gaussian');


figure(2);

subplot(321); imshow(building); title('building');
subplot(322); imhist(building); title('histogram');
subplot(323); imshow(medfilt2(building)); title('median filter');
subplot(324); imshow(imfilter(building, mean)); title('averaging');
subplot(325); imshow(imfilter(building, gauss)); title('gaussian');


% Part B

figure(3);

corner = imread('corner_window.jpg');

subplot(321); imshow(corner); title('corner');
subplot(322); imhist(corner); title('corner_hist');

figure(4);

corridor = imread('corridor.jpg');

subplot(321); imshow(corner); title('corner');
subplot(322); imhist(corner); title('corner_hist');

figure(5);

tree = imread('tree.jpg');

subplot(321); imshow(corner); title('corner');
subplot(322); imhist(corner); title('corner_hist');

figure(6);

nyc = imread('New York City.jpg');

subplot(321); imshow(corner); title('corner');
subplot(322); imhist(corner); title('corner_hist');






