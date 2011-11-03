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
figure; 
subplot(221);imhist(facehue);title('Face'); 

x = 0:0.01:1;

h_m_skin = mymean(facehue(:));
h_s_skin = sqrt(myvariance(facehue(:),h_m_skin));

y = gaussmf(x,[h_s_skin h_m_skin]);
subplot(223); plot(x,y); title('Skin distribution');


subplot(222);imhist(otherhue); title('Other');

h_m_other = mymean(otherhue(:));
h_s_other = sqrt(myvariance(otherhue(:),h_m_other));

y = gaussmf(x,[h_s_other h_m_other]);
subplot(224); plot(x,y); title('Other distribution');


% find normalized green components
figure; 
subplot(221);imhist(facegreen);title('Face'); 

g_m_skin = mymean(facegreen(:));
g_s_skin = sqrt(myvariance(facegreen(:), g_m_skin));

y = gaussmf(x,[g_s_skin g_m_skin]);
subplot(223); plot(x,y); title('Skin distribution');

subplot(222);imhist(othergreen); title('Other');

g_m_other = mymean(othergreen(:));
g_s_other = sqrt(myvariance(othergreen(:),g_m_other));

y = gaussmf(x,[g_s_other g_m_other]);
subplot(224); plot(x,y); title('Other distribution');


count_skin = length(facehue);
count_other = length(otherhue);
p_skin = count_skin/(count_skin+count_other);
p_other = count_other/(count_skin+count_other);
if p_skin < .25
    p_skin=.5;
    p_other=.5;
end

group_img = imread('faces/group.jpg');

group_hsv = rgb2hsv(group_img);
group_hue = mod(group_hsv(:,:,1)+.2,1);

[nmout, bcout] = findskin(group_hue, p_skin, p_other, h_m_skin, h_m_other, h_s_skin, h_s_other);
%display the data
figure;
subplot(311); imshow(group_img); title('Group hue');
subplot(312); imshow(nmout); title('Nearest mean classifier');
subplot(313); imshow(bcout); title('Bayesian classifier');
group_img = double(group_img);
group_green = group_img(:,:,2) ./ (group_img(:,:,1) + group_img(:,:,2) + group_img(:,:,3) + 1);
group_green(isnan(group_green)) = 0;
[nmout,bcout]=findskin(group_green, p_skin, p_other, g_m_skin, g_m_other, g_s_skin, g_s_other);
figure;
subplot(311); imhist(group_green); title('Group green');
subplot(312); imshow(nmout); title('Nearest mean classifier');
subplot(313); imshow(bcout); title('Bayesian classifier');

% face1 =  imread('faces/2/image_0022.jpg');
% findskin(face1, p_skin, p_other, h_m_skin, h_m_other, h_s_skin, h_s_other);
% face2 =  imread('faces/6/image_0113.jpg');
% findskin(face2, p_skin, p_other, h_m_skin, h_m_other, h_s_skin, h_s_other);
% % 
