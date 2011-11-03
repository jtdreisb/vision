% Collects the face masks for all of the images and saves them to disk
% project 4
% Jason, Blake, Jen

dirlist = dir('faces/*');
basedir = 'faces';
x=7;
maskdir = 'masks';
facehue  = [];
otherhue = [];  
facegreen = [];
othergreen = [];
% for x=3: length(dirlist)
    if (dirlist(x).isdir==1)%make sure it's a dir
        imgdir = strcat(basedir,'/',dirlist(x).name);
        imgsearch = strcat(imgdir,'/*.jpg');
        maskfolder = strcat(maskdir,'/',dirlist(x).name);
        
        imlist=dir(imgsearch);
        
        for y=1: length(imlist)
            imgpath = strcat(imgdir,'/',imlist(y).name);
            img = imread(imgpath);
            maskpath = strcat(maskfolder,'/',imlist(y).name);
            mask = imread(maskpath);

            HSVimage = rgb2hsv(img);
            normhue = mod(HSVimage(:,:,1)+.2,1);

            [fhue,ohue] = facedist(normhue,mask);
            facehue = [facehue; fhue(:)];
            otherhue = [otherhue; ohue(:)];

            %repeat for normalized green
            img = double(img);
            
            normgreen = img(:,:,2) ./ (img(:,:,1) + img(:,:,2) + img(:,:,3));
            normgreen(isnan(normgreen)) = 0;
            [fgreen, ogreen] = facedist(normgreen, mask);

            facegreen = [facegreen; fgreen(:)];
            othergreen = [othergreen; ogreen(:)];
        end

    end
% end

% find the hue distributions 
% figure; 
% subplot(221);imhist(facehue);title('Face'); 

% x = 0:0.01:1;

h_m_skin = mymean(facehue(:));
h_s_skin = sqrt(myvariance(facehue(:),h_m_skin));

% y = gaussmf(x,[h_s_skin h_m_skin]);
% subplot(223); plot(x,y); title('Skin distribution');


% subplot(222);imhist(otherhue); title('Other');

h_m_other = mymean(otherhue(:));
h_s_other = sqrt(myvariance(otherhue(:),h_m_other));

% y = gaussmf(x,[h_s_other h_m_other]);
% subplot(224); plot(x,y); title('Other distribution');


% find normalized green components
% figure; 
% subplot(221);imhist(facegreen);title('Face'); 

g_m_skin = mymean(facegreen(:));
g_s_skin = sqrt(myvariance(facegreen(:), g_m_skin));

% y = gaussmf(x,[g_s_skin g_m_skin]);
% subplot(223); plot(x,y); title('Skin distribution');

% subplot(222);imhist(othergreen); title('Other');

g_m_other = mymean(othergreen(:));
g_s_other = sqrt(myvariance(othergreen(:),g_m_other));

% y = gaussmf(x,[g_s_other g_m_other]);
% subplot(224); plot(x,y); title('Other distribution');


% calculating the p_values is not neccessary because they do not accurately
% represent the bayesian clustering
% count_skin = length(facehue);
% count_other = length(otherhue);
% p_skin = count_skin/(count_skin+count_other);
% p_other = count_other/(count_skin+count_other);

% group_img = imread('faces/group.jpg');
group_img = imread('faces/8/image_0138.jpg');

group_hsv = rgb2hsv(group_img);
group_hue = mod(group_hsv(:,:,1)+.2,1);

[hue_nmout, hue_bcout] = findskin(group_hue, .4, .6, h_m_skin, h_m_other, h_s_skin, h_s_other);

%display the data
figure;
subplot(311); imshow(group_img); title('Goatee hue');
subplot(312); imshow(hue_nmout); title('Nearest mean classifier');
subplot(313); imshow(hue_bcout); title('Bayesian classifier');


%plot the normalized green
d_group_img = double(group_img);
group_green = d_group_img(:,:,2) ./ (d_group_img(:,:,1) + d_group_img(:,:,2) + d_group_img(:,:,3));
group_green(isnan(group_green)) = 0;
[green_nmout,green_bcout] = findskin(group_green, .5, .5, g_m_skin, g_m_other, g_s_skin, g_s_other);

figure;
subplot(311); imshow(group_img); title('Goatee green');
subplot(312); imshow(green_nmout); title('Nearest mean classifier');
subplot(313); imshow(green_bcout); title('Bayesian classifier');

% plot 2d feature vector

o_hue = decimate(otherhue,10);
o_green = decimate(othergreen,10);
% figure; scatter(o_hue,o_green);
f_hue = decimate(facehue,10);
f_green = decimate(facegreen,10);
% hold on; scatter(f_hue,f_green);

f_cov = cov(f_hue,f_green)
o_cov = cov(o_hue,o_green)

% face1 =  imread('faces/2/image_0022.jpg');
% findskin(face1, p_skin, p_other, h_m_skin, h_m_other, h_s_skin, h_s_other);
% face2 =  imread('faces/6/image_0113.jpg');
% findskin(face2, p_skin, p_other, h_m_skin, h_m_other, h_s_skin, h_s_other);
% % 
