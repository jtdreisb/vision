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
%for x=3: length(dirlist)
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
            
            normgreen = img(:,:,2) ./ (img(:,:,1) + img(:,:,2) + img(:,:,3) + 1);
            [fgreen, ogreen] = facedist(normgreen, mask);

            facegreen = [facegreen; fgreen(:)];
            othergreen = [othergreen; ogreen(:)];
        end

    end
%end

% find the hue distributions 
figure; 
subplot(221);imhist(facehue);title('Face'); 

x = 0:0.01:1;

h_m_skin = mymean(facehue(:));
h_s_skin = sqrt(myvariance(facehue(:),hfacemean));

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

g_m_other = mymean(facegreen(:));
g_s_other = sqrt(myvariance(facegreen(:),g_m_other));

y = gaussmf(x,[g_s_other g_m_other]);
subplot(224); plot(x,y); title('Other distribution');


count_skin = length(facehue);
count_other = length(otherhue);
p_skin = h_count_skin/(h_count_skin+h_count_other);
p_other = h_count_other/(h_count_skin+h_count_other);


groupimg = imread('faces/group.jpg');

findskin(groupimg, p_skin, p_other, h_m_skin, h_m_other, h_s_skin, h_s_other);




