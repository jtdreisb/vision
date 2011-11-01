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

% load('distributions.mat');
figure; 
subplot(221);imhist(facehue);title('Face'); 

x = 0:0.01:1;

hfacemean = mymean(facehue(:));
hfacevar = myvariance(facehue(:),hfacemean);

y = gaussmf(x,[sqrt(hfacevar) hfacemean]);
subplot(223); plot(x,y);


subplot(222);imhist(otherhue); title('Other');

hothermean = mymean(otherhue(:));
hothervar = myvariance(otherhue(:),hothermean);

y = gaussmf(x,[sqrt(hothervar) hothermean]);
subplot(224); plot(x,y);


figure; 
subplot(221);imhist(facegreen);title('Face'); 

gfacemean = mymean(facegreen(:));
gfacevar = myvariance(facegreen(:),gfacemean);

y = gaussmf(x,[sqrt(gfacevar) hfacemean]);
subplot(223); plot(x,y);

subplot(222);imhist(othergreen); title('Other');

gothermean = mymean(facegreen(:));
gothervar = myvariance(facegreen(:),gfacemean);

y = gaussmf(x,[sqrt(gothervar) gothermean]);
subplot(224); plot(x,y);

% save('gaussians.mat', 'hfacemean','hfacevar','hothermean','hothervar','gfacemean','gfacevar','gothermean', 'gothervar');
% load('gaussians.mat');

groupimg = imread('faces/group.jpg');

grouphsv = rgb2hsv(groupimg);
grouphue = mod(grouphsv(:,:,1)+.2,1);
[groupheight, groupwidth] = size(grouphue);

% skin classification using nearest mean classifier
hnmo=zeros([groupheight groupwidth]);
for r=1: groupheight;
    for c=1: groupwidth;
        % if it is closer to the mean it is a face pixel
        if (abs(hfacemean-grouphue(r,c)) < abs(hothermean-grouphue(r,c)))
            hnmo(r,c) = 1;
        end
    end
end

figure;
imshow(hnmo); title('Nearest mean classifier on hue');

% bayes classification
hbco = zeros([groupheight, groupwidth]);

hfacepxcount = size(facehue);
hotherpxcount = size(otherhue);
hpface = hfacepxcount(1)/(hotherpxcount(1)+hfacepxcount(1));
hpother = hotherpxcount(1)/(hotherpxcount(1)+hfacepxcount(1));

for r=1: groupheight;
    for c=1:groupwidth;
        hbayesface = hpface * gauss_distribution(grouphue(r,c),hfacemean, sqrt(hfacevar));
        hbayesother = hpother * gauss_distribution(grouphue(r,c),hothermean, sqrt(hothervar));
        if (hbayesface > hbayesother)
            hbco(r,c) = 1;
        end
    end
end
figure;
imshow(hbco); title('Bayes Classifier on hues');
