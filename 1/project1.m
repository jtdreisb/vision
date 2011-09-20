% Team Project 1
%
% 9-20-11
% CPE 428
% Team Spaceman: Jason Dreisbach, Blake Rafter, and Jennifer Tighe

%Part A
%Image 1: Group Picture

    %Read image and convert to grayscale.
    im1 = imread('C:\usr\Matlab\group.jpg', 'jpeg');
    figure, imshow(im1);
    im2 = rgb2gray(im1);
    figure, imshow(im2);
    
    max(im2)
    min(im2)
    size(im2)
    
    im3 = imresize(im2, .3);
    figure, imshow(im3);

%Image 2: Landscape

    %Read image and convert to grayscale.
    image1 = imread('C:\usr\Matlab\landscape.jpg', 'jpeg');
    figure, imshow(image1);
    image2 = rgb2gray(image1);
    figure, imshow(image2);
    
    max(image2)
    min(image2)
    size(image2)
    
    image3 = imresize(image2, .1);
    figure, imshow(image3);

%Part B

    %Read image and isolate bacteria from background
    bacteria = imread('C:\usr\Matlab\bacteria.bmp', 'bmp');
    bacteria2 = im2bw(bacteria, .4);
    figure, imshow(bacteria2);
    inversebacteria = ~bacteria2;
    
    %Number of black and white pixels (area)
    x = imhist(inversebacteria);
    
    %Label each bacteria
    L = bwlabel(inversebacteria,8);
    
    %Convert label to color
    M = label2rgb(L);
    figure, imshow(M);
    
    %Area of each bacteria
    for i=1:23, 
        [r,c] = find (L==i); 
        length(r)
    end
    