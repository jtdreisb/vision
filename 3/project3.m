% Project 3

figure;

dirlist = dir('faces/*');
basedir = 'faces';

for x=3: length(dirlist)
	if (dirlist(x).isdir==1)%make sure it's a dir
        imgdir = strcat(basedir,'/',dirlist(x).name);
        imgsearch = strcat(imgdir,'/*.jpg');
        
        imlist=dir(imgsearch);
       
        for y=1: length(imlist)
            imgpath = strcat(imgdir,'/',imlist(y).name);
            faceimage = imread(imgpath);
            imshow(imread(imgpath));
            H = imrect;
            pos = wait(H);
            
            foo = size(faceimage)
            
            maskimage = zeros(foo);
            
            maskimage(pos(1):pos(1)+pos(3)-1,pos(2):pos(2)+pos(4)) = 1;
            imshow(maskimage);
            figure;
        end
    end
end
