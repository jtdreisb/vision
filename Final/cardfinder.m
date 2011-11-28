% Cardfinder.m
% Jason Dreisbach, Blake Rafter, Jen Tighe
% Reference: TILT: Transform Invariant Low-rank Textures  
%            Zhengdong Zhang, Xiao Liang, Arvind Ganesh, and Yi Ma. Proc. of ACCV, 2010.
%

clc;
close all;

%% load the image
[img_name, img_path]=uigetfile('*.*');
img=imread(fullfile(img_path, img_name));

%% Do blob detection
bw_img = im2bw(img,.6);
% Segment
labeled_img = bwlabel(~bw_img,8);
imshow(label2rgb(labeled_img));

% this must be odd
mask_size = 11;
mask = ones(mask_size);
mask_mid = (mask_size+1)/2;
mask(mask_mid,mask_mid)=0;
mask_mid = mask_mid-1;

for i=1:max(labeled_img(:))
    
    [r,c] = find(labeled_img == i);
    if (max(c)-min(c) < 100 || max(r)-min(r) < 100)
        continue
    end
    bits = [r,c];
    % get only the outer most .001%
    outer_bits = bits(max(r)*.999 < bits(:,1),:);
    outer_bits = [outer_bits; bits(min(r)*.001 > bits(:,1),:)];
    outer_bits = [outer_bits; bits(:,max(c)*.999 < bits(:,2))];
    outer_bits = [outer_bits; bits(:,min(c)*.001 > bits(:,2))];
    for j=1:length(r)
        r(j)
        for k=1:length(c)
%             c(k)
            masked_vect = nonzeros(labeled_img(r(i)-mask_mid:r(i)+mask_mid,c(k)-mask_mid:c(k)+mask_mid).*mask);
            
            neighbors = masked_block(masked_block ~= i);
            for n=1:length(neighbors)
                labeled_img(labeled_img == neighbors(n)) = i;
            end
        end
    end
end

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

figure(i+1);
imshow(rectified_img);
cd ..
end
