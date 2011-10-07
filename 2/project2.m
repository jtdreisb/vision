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
subplot(323); imshow(medianfilter(boat,3)); title('median filter');

subplot(324); imshow(myfilter(boat, mean)); title('averaging');


subplot(325); imshow(myfilter(boat, gauss)); title('gaussian');


figure(2);

subplot(321); imshow(building); title('building');
subplot(322); imhist(building); title('histogram');
subplot(323); imshow(medianfilter(building,3)); title('median filter');
subplot(324); imshow(myfilter(building, mean)); title('averaging');
subplot(325); imshow(myfilter(building, gauss)); title('gaussian');


% Part B - Edge Detection

corner = imread('corner_window.jpg');
figure(3); sobel_func(corner);
figure(4); prewitt_func(corner);

corridor = imread('corridor.jpg');
figure(5); sobel_func(corridor);
figure(6); prewitt_func(corridor);

tree = imread('tree.jpg');
figure(7); sobel_func(tree);
figure(8); prewitt_func(tree);

new_york_city = imread('New York City.jpg');
figure(9); sobel_func(new_york_city);
figure(10); prewitt_func(new_york_city);


%% Laplacian of gaussian

figure(11);

subplot(131); imshow(corner);
subplot(132); imshow(lapofgauss(corner, 3, 1));
subplot(133); imshow(lapofgauss(corner, 3, 2));


figure(12);

subplot(131); imshow(corridor);
subplot(132); imshow(lapofgauss(corridor, 3, 1));
subplot(133); imshow(lapofgauss(corridor, 3, 2));

figure(13);

subplot(131); imshow(tree);
subplot(132); imshow(lapofgauss(tree, 3, 1));
subplot(133); imshow(lapofgauss(tree, 3, 2));


figure(14);

subplot(131); imshow(new_york_city);
subplot(132); imshow(lapofgauss(new_york_city, 3, 1));
subplot(133); imshow(lapofgauss(new_york_city, 3, 2));

% Canny Edge Detector

figure(15);

cannyedge(corner);

figure(16);
cannyedge(corridor);

figure(17);
cannyedge(tree);

figure(18);
cannyedge(new_york_city);

% Find the lines with hough transform
figure; myhough(corner);
figure; myhough(corridor);
figure; myhough(tree);
figure; myhough(new_york_city);





