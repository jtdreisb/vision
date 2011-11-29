% Cardfinder.m
% Jason Dreisbach, Blake Rafter, Jen Tighe
% Reference: TILT: Transform Invariant Low-rank Textures  
%            Zhengdong Zhang, Xiao Liang, Arvind Ganesh, and Yi Ma. Proc. of ACCV, 2010.
%

clc;
close all;

cards = cell(1); % put the finished cards in here

%% load the image
[img_name, img_path]=uigetfile('*.*');
img=imread(fullfile(img_path, img_name));
figure; imshow(img);

%% Do blob detection

imgR = squeeze(img(:,:,1));
imgG = squeeze(img(:,:,2));
imgB = squeeze(img(:,:,3));
% threshold with otsu's method
binR = im2bw(imgR, grayThresh(imgR));
binG = im2bw(imgG, grayThresh(imgG));
binB = im2bw(imgB, grayThresh(imgB));
bw_img = imcomplement(binR&binG&binB);

% Segment
labeled_img = bwlabel(bw_img,8);
figure;
imshow(label2rgb(labeled_img));

% this must be odd
mask_size = 5;
mask = ones(mask_size);
mask_mid = (mask_size+1)/2;
mask(mask_mid,mask_mid)=0;
mask_mid = mask_mid-1;

% for i=1:max(labeled_img(:))
%     i
%     [r,c] = find(labeled_img == i);
%     if (length(r) < 10)
%         continue
%     end
%     bits = [r,c];
%     % get only the outer most bits
%     k = [bits(bits(:,1) == max(r),:);...
%                   bits(bits(:,1) == min(r),:);...
%                   bits(bits(:,2) == min(c),:);...
%                   bits(bits(:,2) == max(c),:)];
%     
%     for j=1:length(k(:,1))
%             masked_vect = nonzeros(labeled_img(k(j,1)-mask_mid:k(j,1)+mask_mid,k(j,2)-mask_mid:k(j,2)+mask_mid).*mask);
%             neighbors = masked_vect(masked_vect ~= i);
%             for n=1:length(neighbors)
%                 labeled_img(labeled_img == neighbors(n)) = i;
%             end
%     end
% end

for i=1:max(labeled_img(:))
    [r,c] = find(labeled_img == i);
%% get the top-left and bottom-right corner of the rectangle window where
% we perform TILT.
% by default, the first point should be top-left one and the second should
% be bottom-right. Don't mess up the order......
if (max(c)-min(c) < 100 || max(r)-min(r) < 100)
    continue
end
initial_points=double([min(c),max(c);min(r),max(r)]);

%% Run TILT:
cd TILT
tic
%, 'SAVE_PATH', fullfile(cd, task_name)
[Dotau, A, E, f, tfm_matrix, focus_size, error_sign, UData, VData, XData, YData, A_scale]=...
    TILT(img, 'AFFINE', initial_points,...
    'BLUR_SIGMA', 2, 'BLUR_NEIGHBOR', 2,...
    'PYRAMID_MAXLEVEL', 1, 'DISPLAY_INTER', 0);
toc

%% 1. transform the input image to the focus window.
standard_tfm_matrix=[1 0 1-UData(1); 0 1 1-VData(1); 0 0 1]*tfm_matrix*[1 0 XData(1)-1; 0 1 YData(1)-1; 0 0 1]; % indeed just compose the tfm_matrix with coordinate swtich.
standard_tfm=fliptform(maketform('projective', standard_tfm_matrix'));
rectified_img=imtransform(img, standard_tfm, 'bilinear', 'UData', [1 size(img, 2)], 'VData', [1 size(img, 1)],  'XData', [1 focus_size(2)], 'YData', [1 focus_size(1)], 'Size', focus_size);


%% From the rectified image. Trim and reshape to a known card size

% get our rgb vectors 
imgR = squeeze(rectified_img(:,:,1));
imgG = squeeze(rectified_img(:,:,2));
imgB = squeeze(rectified_img(:,:,3));
% threshold our vectors
binR = im2bw(imgR, grayThresh(imgR));
binG = im2bw(imgG, grayThresh(imgG));
binB = im2bw(imgB, grayThresh(imgB));
% combine the vectors
bw = imcomplement(binR&binG&binB);


figure;
subplot(311);
imshow(bw);

subplot(312);
imshow(rectified_img);

% filter out background pixels
[r,c] = find(bw == 1);

% construct final image
final_img = rectified_img(min(r):max(r),min(c):max(c),:);
subplot(313);
imshow(final_img);
cards{length(cards)}=final_img;
cards = [cards;cell(1)];
cd ..
end


num_cards = length(cards)-1;


square_size = ceil(sqrt(num_cards));

figure;
for i=1:num_cards
subplot(square_size, square_size, i);
imshow(cards{i});
end
